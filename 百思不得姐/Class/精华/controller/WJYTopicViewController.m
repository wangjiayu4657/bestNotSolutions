//
//  WJYWordViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/6/23.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTopicViewController.h"
#import "WJYTopicsModel.h"
#import "WJYTopicsCell.h"

@interface WJYTopicViewController ()

/**数据源*/
@property (strong , nonatomic)  NSMutableArray *dataSource;
/**上拉刷新时需要传该参数*/
@property (assign , nonatomic) NSInteger page;
/**上拉刷新加载下一页内容时需要此参数*/
@property (copy , nonatomic) NSString *maxtime;
/**保存上一次的请求参数,目的是为了只处理最后一次请求回来的数据*/
@property (strong , nonatomic)  NSDictionary *params;

@end


@implementation WJYTopicViewController

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    [self setUpRefresh];
}

//设置 tableView 的内边距
- (void) setUpTableView {
    CGFloat top = titleViewY + titleViewHeight;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WJYTopicsCell class]) bundle:nil] forCellReuseIdentifier:topicCellID];
    
}

//初始化上下拉刷新
- (void) setUpRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

/**
 *  下拉加载新帖子
 */
- (void) loadNewTopics {
    
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:5];
    param[@"a"] = @"list";
    param[@"c"] = @"data";
    param[@"type"] = @(self.type);
    self.params = param;
    
    HttpClient *aClient = [HttpClient sharedClient];
    [aClient getPath:@"http://api.budejie.com/api/api_open.php" params:param resultBlock:^(id responseObject, NSError *error) {
        NSLog(@"responseObject:%@",responseObject);
        if (!error) {
            if (self.params != param) return;
            self.maxtime = responseObject[@"info"][@"maxtime"];
            self.dataSource = [WJYTopicsModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                self.page = 0;
            });
        }else {
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

/**
 *  上拉加载更多帖子
 */
- (void) loadMoreTopics {
    self.page++;
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:5];
    param[@"a"] = @"list";
    param[@"c"] = @"data";
    param[@"type"] = @(self.type);
    param[@"page"] = @(self.page);
    param[@"maxtime"] = self.maxtime;
    self.params = param;
    
    HttpClient *aClient = [HttpClient sharedClient];
    [aClient getPath:@"http://api.budejie.com/api/api_open.php" params:param resultBlock:^(id responseObject, NSError *error) {
        if (!error) {
            if (self.params != param) return;
            self.maxtime = responseObject[@"info"][@"maxtime"];
            NSArray *newTopics = [WJYTopicsModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [self.dataSource addObjectsFromArray:newTopics];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView.mj_footer endRefreshing];
            });
        }else {
            [self.tableView.mj_footer endRefreshing];
            //如果请求失败则恢复上一次的页码
            self.page--;
        }
    }];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.dataSource.count == 0);
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJYTopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellID];
    
    cell.topic = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJYTopicsModel *model = self.dataSource[indexPath.row];
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * topicCellMargin, MAXFLOAT);
    //文字内容的高度
    CGFloat textHeight = [model.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    CGFloat cellHeight = textHeight + topicCellTextY + topicCellBottomBarHeight + 2 * topicCellMargin;
    
    return cellHeight;
}


@end
