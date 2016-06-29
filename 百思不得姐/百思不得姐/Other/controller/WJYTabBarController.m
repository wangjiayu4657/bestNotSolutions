//
//  WJYTabBarController.m
//  百思不得姐
//
//  Created by fangjs on 16/6/14.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTabBarController.h"
#import "WJYEssenceViewController.h"
#import "WJYNewViewController.h"
#import "WJYFriendTrendsViewController.h"
#import "WJYMeViewController.h"
#import "WJYTabBar.h"
#import "WJYNavigationController.h"

@interface WJYTabBarController ()

@end

@implementation WJYTabBarController

//当第一次调用这个类时会调用该方法
+ (void)initialize {
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpChildContoller:[[WJYEssenceViewController alloc] init] itmeTitlt:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    [self setUpChildContoller:[[WJYNewViewController alloc] init] itmeTitlt:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    [self setUpChildContoller:[[WJYFriendTrendsViewController alloc] init] itmeTitlt:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    [self setUpChildContoller:[[WJYMeViewController alloc] init] itmeTitlt:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[WJYTabBar alloc] init] forKeyPath:@"tabBar"];
}

- (void) setUpChildContoller:(UIViewController *)controller itmeTitlt:(NSString *) itmeTitle image:(NSString *) image selectImage:(NSString *) selectImage {
    controller.tabBarItem.title = itmeTitle;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    WJYNavigationController *navigationController = [[WJYNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:navigationController];
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

@end
