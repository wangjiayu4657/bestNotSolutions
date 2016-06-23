//
//  UIBarButtonItem+WJYExtension.m
//  百思不得姐
//
//  Created by fangjs on 16/6/14.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "UIBarButtonItem+WJYExtension.h"

@implementation UIBarButtonItem (WJYExtension)

+(instancetype)itemWithImage:(NSString *)image highLightImage:(NSString *)highLightImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
     button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}
@end
