//
//  WJYPushGuideView.m
//  百思不得姐
//
//  Created by fangjs on 16/6/21.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYPushGuideView.h"

@implementation WJYPushGuideView

+(void)show {
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sanboxVersion]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        WJYPushGuideView *guideView = [WJYPushGuideView viewFromXib];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)IKnow:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
         [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
