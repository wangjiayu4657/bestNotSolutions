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

@interface WJYCommentViewController ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textfieldBottomConstraint;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation WJYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBasic];
   
    
}

- (void) setUpBasic {
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highLightImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    WJYTopicsCell *topicCell = [WJYTopicsCell cell];
    topicCell.topic = self.topicModel;
    topicCell.height = self.topicModel.cellHeight;
    self.tableView.tableHeaderView = topicCell;
    
}

- (void) keyboardWillChangeFrame:(NSNotification *) noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardHeight = screenHeight - rect.origin.y;
    self.textfieldBottomConstraint.constant = keyboardHeight;
    
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
