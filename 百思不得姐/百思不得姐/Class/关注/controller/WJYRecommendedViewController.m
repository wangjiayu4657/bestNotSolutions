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

@interface WJYRecommendedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

/**菜单数据源*/
@property (strong , nonatomic)  NSMutableArray *dataSource;

@end


static NSString * const menuCellID = @"menuCell";
static NSString * const contentCellID = @"contentCell";

@implementation WJYRecommendedViewController


-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = GlobalColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 注册
    [self.menuTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WJYMenuCell class]) bundle:nil] forCellReuseIdentifier:menuCellID];
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WJYContentCell class]) bundle:nil] forCellReuseIdentifier:contentCellID];

    self.contentTableView.rowHeight = 80;
}

- (void) viewWillAppear:(BOOL)animated {
    [SVProgressHUD show];
    HttpClient *aClient = [HttpClient sharedClient];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:2];
    param[@"a"] = @"category";
    param[@"c"] = @"subscribe";
    [aClient getPath:@"http://api.budejie.com/api/api_open.php" params:param resultBlock:^(id responseObject, NSError *error) {
        if (!error) {
            [SVProgressHUD dismiss];
            self.dataSource = [WJYMenuModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            NSLog(@"%@",self.dataSource);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.menuTableView reloadData];
                //默认选中首行
                [self.menuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            });
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
        }
    }];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    WJYMenuModel *model ;
    
    if (tableView == self.menuTableView) { //左边的菜单表格
         return self.dataSource.count;
    }else { //右边的内容表格
        if (self.dataSource.count) {
           model = self.dataSource[self.menuTableView.indexPathForSelectedRow.row]; //取出左边被选中类别的数据模型
        }
        return model.users.count;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.menuTableView) { //左边的菜单表格
        WJYMenuCell *menuCell = [tableView dequeueReusableCellWithIdentifier:menuCellID];
        menuCell.model = self.dataSource[indexPath.row];
        return menuCell;
    }else { //右边的内容表格
        WJYContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:contentCellID];
        WJYMenuModel *model = self.dataSource[self.menuTableView.indexPathForSelectedRow.row];
        contentCell.contentModel = model.users[indexPath.row];
        return contentCell;
    }
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WJYMenuModel *model = self.dataSource[indexPath.row];
    if (model.users.count) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.contentTableView reloadData];
        });
    }else {
        HttpClient *aClient = [HttpClient sharedClient];
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:2];
        param[@"a"] = @"list";
        param[@"c"] = @"subscribe";
        param[@"category_id"] = @(model.id);
        [aClient getPath:@"http://api.budejie.com/api/api_open.php" params:param resultBlock:^(id responseObject, NSError *error) {
            NSLog(@"%@",responseObject);
            //字典数组 -> 模型数组
            NSArray *array = [WJYContentModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //添加到当前菜单类别对应的内容数组中
            [model.users addObjectsFromArray:array];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.contentTableView reloadData];
            });
        }];
    }
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
