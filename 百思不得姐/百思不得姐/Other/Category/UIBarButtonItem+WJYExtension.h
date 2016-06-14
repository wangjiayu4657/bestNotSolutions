//
//  UIBarButtonItem+WJYExtension.h
//  百思不得姐
//
//  Created by fangjs on 16/6/14.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WJYExtension)

+ (instancetype) itemWithImage:(NSString *) image highLightImage:(NSString *) highLightImage target:(id) target action:(SEL) action;

@end
