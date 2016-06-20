//
//  WJYEssenceViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/6/14.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYEssenceViewController.h"
#import "WJYRecommendedTagViewController.h"
@interface WJYEssenceViewController ()

@end

@implementation WJYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highLightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    self.view.backgroundColor = GlobalColor;
}

- (void) tagClick {
    [self.navigationController pushViewController:[[WJYRecommendedTagViewController alloc] init] animated:YES];
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
