//
//  WJYLoginRegisterViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/6/20.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYLoginRegisterViewController.h"
#import "WJYTopWindow.h"

@interface WJYLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;

@end

@implementation WJYLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //将自定义的 window 隐藏则状态栏会变白,否则状态栏的颜色变黑
    [WJYTopWindow hide];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//设置状态栏为白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)loginOrRegisterButton:(UIButton *)sender {
    //隐藏键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        sender.selected = YES;
        self.loginViewLeftMargin.constant -= self.view.width;
    }else {
        sender.selected = NO;
        self.loginViewLeftMargin.constant = 0;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)back:(id)sender {
    //当界面消失时恢复状态栏为黑色
    [WJYTopWindow show];
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
