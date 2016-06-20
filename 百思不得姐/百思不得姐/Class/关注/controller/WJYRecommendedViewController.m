//
//  WJYRecommendedViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/6/15.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYRecommendedViewController.h"
#import "WJYMenuModel.h"
#import "WJYMenuCell.h"
#import "WJYContentCell.h"



#define selectedMenuTableViewCell self.dataSource[self.menuTableView.indexPathForSelectedRow.row]

@interface WJYRecommendedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

/**菜单数据源*/
@property (strong , nonatomic)  NSMutableArray *dataSource;

/**请求参数*/
@property (strong , nonatomic)  NSMutableDictionary *params;

@end

@implementation WJYRecommendedViewController


-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    [self loadMenuContent];
}

//初始化 TableView
- (void) setUpTableView {
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = GlobalColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 注册
    [self.menuTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WJYMenuCell class]) bundle:nil] forCellReuseIdentifier:menuCellID];
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WJYContentCell class]) bundle:nil] forCellReuseIdentifier:contentCellID];
    self.contentTableView.rowHeight = 80;
    
    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewContent)];
    self.contentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreContent)];
    self.contentTableView.mj_footer.hidden = YES;
}

//下拉刷新
- (void) loadNewContent {
    WJYMenuModel *model = selectedMenuTableViewCell;
    model.currentPage = 1;
    HttpClient *aClient = [HttpClient sharedClient];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:4];
    param[@"a"] = @"list";
    param[@"c"] = @"subscribe";
    param[@"page"] = @(model.currentPage);
    param[@"category_id"] = @(model.id);
    self.params = param;
    [aClient getPath:@"http://api.budejie.com/api/api_open.php" params:param resultBlock:^(id responseObject, NSError *error) {
        if (!error) {
            //字典数组 -> 模型数组
            NSArray *array = [WJYContentModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //先清空所有的旧数据
            [model.users removeAllObjects];
            //添加到当前菜单类别对应的内容数组中
            [model.users addObjectsFromArray:array];
            model.total = [responseObject[@"total"] integerValue];
            if (self.params != param) return;//如果是最后一次请求才进行刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.contentTableView reloadData];
                [self.contentTableView.mj_header endRefreshing];
                [self checkFooterStatus];
            });
        }else {
            if (self.params != param) return;
            [self.contentTableView.mj_header endRefreshing];
        }
    }];
}

//上拉刷新
- (void) loadMoreContent {
    WJYMenuModel *model = selectedMenuTableViewCell;
    HttpClient *aClient = [HttpClient sharedClient];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:4];
    param[@"a"] = @"list";
    param[@"c"] = @"subscribe";
    param[@"category_id"] = @(model.id);
    param[@"page"] = @(++model.currentPage);
    self.params = param;
    [aClient getPath:@"http://api.budejie.com/api/api_open.php" params:param resultBlock:^(id responseObject, NSError *error) {
        if (!error) {
            //字典数组 -> 模型数组
            NSArray *array = [WJYContentModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //添加到当前菜单类别对应的内容数组中
            [model.users addObjectsFromArray:array];
            model.total = [responseObject[@"total"] integerValue];
            if (self.params != param) return;//如果是最后一次请求才进行刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.contentTableView reloadData];
                if (model.total == model.users.count) {
                    [self.contentTableView.mj_footer endRefreshingWithNoMoreData];
                }else {
                    [self.contentTableView.mj_footer endRefreshing];
                }
            });
        }else {
            if (self.params != param) return;
            [self.contentTableView.mj_footer endRefreshing];
        }
    }];
}

//加载菜单栏的数据
- (void) loadMenuContent {
    [SVProgressHUD show];
    HttpClient *aClient = [HttpClient sharedClient];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:2];
    param[@"a"] = @"category";
    param[@"c"] = @"subscribe";
    [aClient getPath:@"http://api.budejie.com/api/api_open.php" params:param resultBlock:^(id responseObject, NSError *error) {
        if (!error) {
            [SVProgressHUD dismiss];
            self.dataSource = [WJYMenuModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.menuTableView reloadData];
                //默认选中首行
                [self.menuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
                self.contentTableView.dataSource = self;//数据下载完成后再刷新contentTableView表格
                [self.contentTableView.mj_header beginRefreshing];
            });
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
        }
    }];
}

//时刻检测 footer 的状态
- (void) checkFooterStatus {
    WJYMenuModel *model = selectedMenuTableViewCell;
    self.contentTableView.mj_footer.hidden = (model.users.count == 0);//根据被选中的模型是否有数据来决定是否显示上拉刷新
    if (model.total == model.users.count) {
        [self.contentTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.contentTableView.mj_footer endRefreshing];
    }

}

#pragma mark - <UITableViewDataSource>
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //左边的菜单表格
    if (tableView == self.menuTableView)  return self.dataSource.count;//右边的内容表格
    //检测 footer 的状态
    [self checkFooterStatus];
    return [selectedMenuTableViewCell users].count;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.menuTableView) { //左边的菜单表格
        WJYMenuCell *menuCell = [tableView dequeueReusableCellWithIdentifier:menuCellID];
        menuCell.model = self.dataSource[indexPath.row];
        return menuCell;
    }else { //右边的内容表格
        WJYContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:contentCellID];
        WJYMenuModel *model = selectedMenuTableViewCell;
        contentCell.contentModel = model.users[indexPath.row];
        return contentCell;
    }
}

#pragma mark - <UITaleViewDelegate>

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.contentTableView.mj_header endRefreshing];
    [self.contentTableView.mj_footer endRefreshing];
    
    WJYMenuModel *model = self.dataSource[indexPath.row];
    if (model.users.count) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.contentTableView reloadData];
        });
    }else {
        //解决网络有延迟的话界面内容刷新迟滞的现象
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.contentTableView reloadData];
            [self.contentTableView.mj_header beginRefreshing];
        });
    }
}

//控制器销毁时取消所有的数据请求
-(void)dealloc {
    [[HttpClient sharedClient].operationQueue cancelAllOperations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/**
 1.重复发送请求
 2.目前只能显示1页数据
 3.网络慢带来的细节问题
 */
@end
