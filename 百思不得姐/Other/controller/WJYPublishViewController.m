//
//  WJYPublishViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/7/1.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYPublishViewController.h"
#import "WJYVerticalButton.h"


static CGFloat const springAnimationTime = 0.1;
static CGFloat const springAnmationFactors = 10;

@interface WJYPublishViewController ()

@end

@implementation WJYPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //每行最多显示的列数
    int count = 3;
    //按钮起始的横向间距
    CGFloat startMarginX = 25;
    //按钮的宽度
    CGFloat buttonWidth = 72;
    //按钮的高度
    CGFloat buttonHeight = buttonWidth + 30;
    CGFloat buttonX = 0;
    //按钮起始的纵向间距
    CGFloat buttonStartY = (screenHeight - 2 * buttonHeight) / (count - 1) ;
    //按钮之间的间距
    CGFloat margin = (screenWidth - 2 * startMarginX - count * buttonWidth) / (count - 1);
    
    //中间的六个按钮
    for (int i = 0 ; i < images.count ; i++) {
        WJYVerticalButton * button = [WJYVerticalButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:button];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        //列数
        int row = i % count;
        //行数
        int col = i / count;
        //按钮的横向坐标
        buttonX = startMarginX + row * (margin + buttonWidth);
        //按钮动画结束时的 Y 值
        CGFloat buttonEndY = buttonStartY + col * buttonHeight;
        //按钮开始动画时的 Y 值
        CGFloat buttonBeginY = buttonEndY - screenHeight;
        //通过 pop 框架来做动画
        POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        //起始位置
        springAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonWidth, buttonHeight)];
        //结束时的位置
        springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonWidth, buttonHeight)];
        //动画的开始时间
        springAnimation.beginTime = CACurrentMediaTime() + i * springAnimationTime;
        //影响动画弹簧效果的两个因素
        springAnimation.springBounciness = springAnmationFactors;
        springAnimation.springSpeed = springAnmationFactors;
        //添加动画
        [button pop_addAnimation:springAnimation forKey:nil];
    }
    
    
    UIImageView * sloganImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganImageView];
    
    CGFloat sloganImageViewX = screenWidth * 0.5;
    CGFloat sloganImageViewEndY = screenHeight * 0.2;
    CGFloat sloganImageViewBeginY = sloganImageViewEndY - screenHeight;
    
    POPSpringAnimation *sAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    sAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(sloganImageViewX, sloganImageViewBeginY)];
    sAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(sloganImageViewX, sloganImageViewEndY)];
    sAnimation.springSpeed = springAnmationFactors;
    sAnimation.springBounciness = springAnmationFactors;
    sAnimation.beginTime = CACurrentMediaTime() + images.count * springAnimationTime;
    
    [sloganImageView pop_addAnimation:sAnimation forKey:nil];
}

- (IBAction)cancleButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
