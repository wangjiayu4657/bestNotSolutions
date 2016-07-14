//
//  WJYCommentViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/7/11.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYCommentViewController.h"
#import "WJYTopicsCell.h"
#import "WJYTopicsModel.h"
#import "WJYComment.h"
#import "WJYCommentHeaderView.h"
#import "WJYCommentCell.h"

@interface WJYCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textfieldBottomConstraint;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**最热评论*/
@property (strong , nonatomic)  NSArray *hotComment;

/**最新评论*/
@property (strong , nonatomic)  NSMutableArray *latestComment;

/** 先将最热评论的数据保存下来,然后在清空*/
@property (strong , nonatomic)  WJYComment *saveTopic_top_cmt;

/**页码*/
@property(assign , nonatomic) NSInteger page;

@end

@implementation WJYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBasic];
    [self setUpHeader];
    [self setUpRefresh];
}

- (void) setUpBasic {
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highLightImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    //监听键盘弹出时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, topicCellMargin, 0);
    self.tableView.backgroundColor = GlobalColor;
    //自动计算 cell 的高度(一下两点缺一不可,切 ios8以后才行)
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WJYCommentCell class]) bundle:nil] forCellReuseIdentifier:commentCellID];
}

- (void) setUpHeader {
    //点击最热评论进入最热评论界面后 cell 中的最热评论要隐藏
    if (self.topicModel.top_cmt) {
        self.saveTopic_top_cmt = self.topicModel.top_cmt;
        self.topicModel.top_cmt = nil;
        [self.topicModel setValue:@0 forKeyPath:@"cellHeight"];
    }

    //tableView 的 headerView
    UIView *header = [[UIView alloc] init];
    
    //将 topicCell 作为 headerView 中的 view
    WJYTopicsCell *topicCell = [WJYTopicsCell cell];
    topicCell.topic = self.topicModel;
    topicCell.size = CGSizeMake(screenWidth, self.topicModel.cellHeight);
    //设置 headerView 的高度
    header.height = self.topicModel.cellHeight + topicCellMargin;
    [header addSubview:topicCell];
    //设置 headerView
    self.tableView.tableHeaderView = header;

}
//设置刷新
- (void) setUpRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
    self.tableView.mj_footer.hidden = YES;
}

//下拉刷新
- (void) loadNewComment {
    //下拉刷新时结束上拉刷新
    [self.tableView.mj_footer endRefreshing];
    
    HttpClient *aClient = [HttpClient sharedClient];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.ID;
    params[@"hot"] = @"1";
    [aClient getPath:@"http://api.budejie.com/api/api_open.php" params:params resultBlock:^(id responseObject, NSError *error) {
        if (!error) {
            self.page = 1;
            //最热评论
            self.hotComment = [WJYComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
            //最新评论
            self.latestComment = [WJYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            });
            
            NSInteger total = [responseObject[@"total"] integerValue];
            if (self.latestComment.count >= total) {
                self.tableView.mj_footer.hidden = YES;
            }
        }else {
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

//上拉刷新
- (void) loadMoreComment {
    //上拉刷新时结束下拉刷新
    [self.tableView.mj_header endRefreshing];
    
    NSInteger page = self.page + 1;
    
    HttpClient *aClient = [HttpClient sharedClient];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:6];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.ID;
    params[@"page"] = @(page);
    WJYComment *comment = [self.latestComment lastObject];
    params[@"lastcid"] = comment.ID;
   
    [aClient getPath:@"http://api.budejie.com/api/api_open.php" params:params resultBlock:^(id responseObject, NSError *error) {
        if (!error) {
            
            if (![responseObject isKindOfClass:[NSDictionary class]]) {
                [self.tableView.mj_footer endRefreshing];
                self.tableView.mj_footer.hidden = YES;
                return ;
            }
            //最新评论
            NSArray *newComments = [WJYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.latestComment addObjectsFromArray:newComments];
            //页码
            self.page = page;
            //刷新数据
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            //如果评论数组的总数大于等于返回的总数则说明没有新数据了,即底部的上拉刷新要隐藏
            NSInteger total = [responseObject[@"total"] integerValue];
            NSLog(@"total = %zd",total);
            if (self.latestComment.count >= total) {
                self.tableView.mj_footer.hidden = YES;
            }else {
                [self.tableView.mj_footer endRefreshing];
            }
        }else {
            [self.tableView.mj_footer endRefreshing];
            self.page--;
        }
    }];
}

- (void) keyboardWillChangeFrame:(NSNotification *) noti {
    //获取键盘的 frame
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //用屏幕的高度减去键盘的 y 值即是键盘的高度
    CGFloat keyboardHeight = screenHeight - rect.origin.y;
    //更改底部工具条的约束值
    self.textfieldBottomConstraint.constant = keyboardHeight;
    //取出键盘弹出时动画所需的时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //设置动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

//判断要返回那个数组
- (NSArray *) commentInSection:(NSInteger ) section{
    NSInteger hotCount = self.hotComment.count;
    //第0组如果最热评论有数据的话则返回最热评论数组否则返回最新评论数组
    if (section == 0) return hotCount ? self.hotComment : self.latestComment;
    //非0组,返回最新评论数组
    return self.latestComment;
}
//返回数据模型
- (WJYComment *) commentInIndexPath:(NSIndexPath *) indexPath {
    return [self commentInSection:indexPath.section][indexPath.row];
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger hotCount = self.hotComment.count;
    NSInteger latestCount = self.latestComment.count;
    //如果有最热评论则返回两组
    if(hotCount) return 2;
    //如果没有最热评论的话则返回一组
    if(latestCount) return 1;
    //否则返回0组
    return 0;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger hotCount = self.hotComment.count;
    NSInteger latestCount = self.latestComment.count;
    tableView.mj_footer.hidden = (latestCount == 0);//如果没有最新评论则隐藏底部刷新
    if (section == 0) return hotCount ? hotCount : latestCount;
    return latestCount;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WJYCommentHeaderView *commentHeaderView = [WJYCommentHeaderView headerViewWithTableView:tableView];
    
    NSInteger hotCount = self.hotComment.count;
    if (section == 0) {
       commentHeaderView.title = hotCount ? @"最热评论" : @"最新评论";
    }else {
       commentHeaderView.title =  @"最新评论";
    }
    
    return commentHeaderView;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WJYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
   
    cell.comment = [self commentInIndexPath:indexPath];

    return cell;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {//如果 UIMenuController 已经显示,再次点击时则隐藏
        [menu setMenuVisible:NO animated:YES];
        return;
    }
    //获取 cell
    WJYCommentCell *cell = (WJYCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    //让 cell 成为第一响应者
    [cell becomeFirstResponder];
    CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
    UIMenuItem *dingItem = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem *replayItem = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
    UIMenuItem *reportItem = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
    menu.menuItems = @[dingItem,replayItem,reportItem];
    [menu setTargetRect:rect inView:cell];
    [menu  setMenuVisible:YES animated:YES];
}

#pragma mark - UIMenuItem 处理
//顶
- (void) ding:(UIMenuController *) menu {
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSLog(@"%@",[self commentInIndexPath:path].content);
}
//回复
- (void) replay:(UIMenuController *) menu {
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSLog(@"%@",[self commentInIndexPath:path].content);
}
//举报
- (void) report:(UIMenuController *) menu {
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSLog(@"%@",[self commentInIndexPath:path].content);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.saveTopic_top_cmt) {
         self.topicModel.top_cmt = self.saveTopic_top_cmt;
        [self.topicModel setValue:@0 forKeyPath:@"cellHeight"];
    }
//    [self.aClient invalidateSessionCancelingTasks:YES];
}



//    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //最新评论
//        NSArray *newComments = [WJYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        [self.latestComment addObjectsFromArray:newComments];
//
//        [self.tableView reloadData];
//
//        NSInteger total = [responseObject[@"total"] integerValue];
//        if (self.latestComment.count >= total) {
//            self.tableView.mj_footer.hidden = YES;
//        }else {
//            [self.tableView.mj_footer endRefreshing];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self.tableView.mj_footer endRefreshing];
//    }];


@end
