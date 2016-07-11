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


@interface WJYCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textfieldBottomConstraint;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**最热评论*/
@property (strong , nonatomic)  NSArray *hotComment;

/**最新评论*/
@property (strong , nonatomic)  NSMutableArray *latestComment;

/** 先将最热评论的数据保存下来,然后在清空*/
@property (strong , nonatomic)  WJYComment *saveTopic_top_cmt;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
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
//下拉刷新
- (void) setUpRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNewContent)];
    [self.tableView.mj_header beginRefreshing];
}

- (void) loadMoreNewContent {
    HttpClient *aClient = [HttpClient sharedClient];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.ID;
    params[@"hot"] = @"1";
    [aClient getPath:@"http://api.budejie.com/api/api_open.php" params:params resultBlock:^(id responseObject, NSError *error) {
        //最热评论
        self.hotComment = [WJYComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
        self.latestComment = [WJYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        });
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
    static NSString *cellID = @"commnet";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    WJYComment *comment = [self commentInIndexPath:indexPath];
    cell.textLabel.text = comment.content;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.saveTopic_top_cmt) {
         self.topicModel.top_cmt = self.saveTopic_top_cmt;
        [self.topicModel setValue:@0 forKeyPath:@"cellHeight"];
    }
    
}

@end
