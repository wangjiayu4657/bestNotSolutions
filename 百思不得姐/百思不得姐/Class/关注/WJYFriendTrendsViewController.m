//
//  WJYFriendTrendsViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/6/14.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYFriendTrendsViewController.h"
#import "WJYRecommendedViewController.h"
#import "WJYLoginRegisterViewController.h"
@interface WJYFriendTrendsViewController ()

@end

@implementation WJYFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highLightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    self.view.backgroundColor = GlobalColor;
}

- (void) friendsClick {
    WJYRecommendedViewController *controller = [[WJYRecommendedViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


- (IBAction)LoginRegisterButton:(id)sender {
    [self presentViewController:[[WJYLoginRegisterViewController alloc] init] animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
