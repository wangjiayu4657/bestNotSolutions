//
//  WJYTabBar.m
//  百思不得姐
//
//  Created by fangjs on 16/6/14.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTabBar.h"

@interface WJYTabBar ()

/**发布按钮*/
@property (strong , nonatomic)  UIButton *publishButton;

@end

@implementation WJYTabBar

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [self.publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        self.publishButton.size = self.publishButton.currentBackgroundImage.size;
        [self addSubview:self.publishButton];
        
        //设置 TabBar 的背景图片
//        UIImage *img = [UIImage imageNamed:@"tabbar-light"];
//        UIColor *color = [UIColor colorWithPatternImage:img];
//        self.backgroundColor = color;
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;

    self.publishButton.center = CGPointMake(width * 0.5,height * 0.5);

    CGFloat barButtonY = 0;
    CGFloat barButtonWidth = width / 5.0;
    CGFloat barButtonHeight = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        CGFloat barButtonX = barButtonWidth * (index > 1 ? (index + 1) : index);
        button.frame = CGRectMake(barButtonX, barButtonY, barButtonWidth, barButtonHeight);
        index ++;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
