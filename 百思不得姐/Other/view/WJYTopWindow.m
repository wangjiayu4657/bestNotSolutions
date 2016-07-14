//
//  WJYTopWindow.m
//  百思不得姐
//
//  Created by fangjs on 16/7/12.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTopWindow.h"


@implementation WJYTopWindow

static UIWindow *window_;

+ (void)initialize {
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, screenWidth, 20);
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor clearColor];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
}

+(void)show {
    window_.hidden = NO;
}

+(void)hide {
    window_.hidden = YES;
}



+ (void)tapAction {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}


+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}

/*
+ (void) searchScrollViewInView:(UIView *) superView {
    for (UIScrollView *subview in superView.subviews) {
        //将subview.frame在subview.superview上的坐标系转换为在window上的坐标系,然后进行比较,看 subview 是否在 window 上即当前窗口能否看到 subview
        CGRect newFrame = [subview.superview convertRect:subview.frame toView:nil];//nil 代表 view 为 window
        CGRect windowBounds = [UIApplication sharedApplication].keyWindow.bounds;
        //如果subview 在 window 上即,当前窗口上能看到 subview 则返回 yes, 否则返回 no
        //CGRectIntersectsRect 判断两个矩形块儿是否交叉
        //CGRectContainsRect 判断两个矩形是否有重叠
        BOOL isShowingOnWindow =!subview.isHidden && subview.alpha > 0.01 && CGRectIntersectsRect(newFrame, windowBounds);
        NSLog(@"%zd",isShowingOnWindow);
        //遍历控件,如果是 scrollView 且当前窗口能看到则让 scrollView 向上滑动到最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && isShowingOnWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        [self searchScrollViewInView:subview];
    }
}
*/

@end
