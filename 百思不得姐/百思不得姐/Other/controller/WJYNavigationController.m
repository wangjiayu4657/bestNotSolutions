//
//  WJYNavigationController.m
//  百思不得姐
//
//  Created by fangjs on 16/6/15.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYNavigationController.h"

@implementation WJYNavigationController

//当第一次调用这个类时会调用该方法
+(void)initialize {
  [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //判断是否为第一个控制器,如果不是则创建导航栏上返回按钮的样式
    if (self.childViewControllers.count > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.size = CGSizeMake(70, 30);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//让按钮的内容全部左对齐
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //这句放在后面是为了让viewController可以更改leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void) back {
    [self popViewControllerAnimated:YES];
}

@end
