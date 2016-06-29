//
//  WJYMeViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/6/14.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYMeViewController.h"

@interface WJYMeViewController ()

@end

@implementation WJYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    UIBarButtonItem *settingButton = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highLightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonButton = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highLightImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingButton,moonButton];
    self.view.backgroundColor = GlobalColor;
}

- (void) settingClick {
    LogFunction;
}

- (void) moonClick {
    LogFunction;
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
