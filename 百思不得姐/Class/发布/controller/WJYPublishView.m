//
//  WJYPublishView.m
//  百思不得姐
//
//  Created by fangjs on 16/7/1.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYPublishView.h"
#import "WJYVerticalButton.h"
#import "WJYPostWordViewController.h"
#import "WJYNavigationController.h"

#define WJYWindowControllerView  [UIApplication sharedApplication].keyWindow.rootViewController.view

static CGFloat const springAnimationTime = 0.1;
static CGFloat const springAnmationFactors = 10;

@interface WJYPublishView ()

@end

@implementation WJYPublishView



- (void)awakeFromNib {
    WJYWindowControllerView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    
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
        [self addSubview:button];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
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
    [self addSubview:sloganImageView];
    
    CGFloat sloganImageViewX = screenWidth * 0.5;
    CGFloat sloganImageViewEndY = screenHeight * 0.2;
    CGFloat sloganImageViewBeginY = sloganImageViewEndY - screenHeight;
    
    POPSpringAnimation *sAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    sAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(sloganImageViewX, sloganImageViewBeginY)];
    sAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(sloganImageViewX, sloganImageViewEndY)];
    sAnimation.springSpeed = springAnmationFactors;
    sAnimation.springBounciness = springAnmationFactors;
    sAnimation.beginTime = CACurrentMediaTime() + images.count * springAnimationTime;
    [sAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        self.userInteractionEnabled = YES;
        WJYWindowControllerView.userInteractionEnabled = YES;
    }];
    
    [sloganImageView pop_addAnimation:sAnimation forKey:nil];
}

- (void) buttonClick:(UIButton *) button {
    [self cancleCompletion:^{
        switch (button.tag) {
            case 0:
                NSLog(@"发视频");
                break;
            case 1:
                NSLog(@"发图片");
                break;
            case 2:{
                NSLog(@"发段子");
                WJYPostWordViewController *postWord = [[WJYPostWordViewController alloc] init];
                WJYNavigationController *nav = [[WJYNavigationController alloc] initWithRootViewController:postWord];
                UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
                [root presentViewController:nav animated:YES completion:nil];
            }
                break;
            case 3:
                NSLog(@"发声音");
                break;
            case 4:
                NSLog(@"审贴");
                break;
            case 5:
                NSLog(@"离线下载");
                break;
                
            default:
                break;
        }
    }];
}

- (void) cancleCompletion:(void(^)())completion {
    self.userInteractionEnabled = NO;
    WJYWindowControllerView.userInteractionEnabled = NO;
    int index = 2;
    for (int i = index; i < self.subviews.count; i++) {
        UIView *btn = self.subviews[i];
        
        CGFloat sloganImageViewEndY = screenHeight + btn.centerY;
        POPBasicAnimation *sAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        //动画执行的节奏(先慢后快)
        //sAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        sAnimation.beginTime = CACurrentMediaTime() + ( i - index )* springAnimationTime;
        sAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(btn.centerX, sloganImageViewEndY)];
        [btn pop_addAnimation:sAnimation forKey:nil];
        
        if (i == self.subviews.count - 1) {
            [sAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
                WJYWindowControllerView.userInteractionEnabled = YES;
                [self removeFromSuperview];
                if (completion) {
                    completion();
                }
            }];
        }
    }
}

- (IBAction)cancleButton {
    [self cancleCompletion:nil];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancleCompletion:nil];
}

@end
