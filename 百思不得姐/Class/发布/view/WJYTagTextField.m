//
//  WJYTagTextField.m
//  百思不得姐
//
//  Created by fangjs on 16/7/20.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTagTextField.h"

@implementation WJYTagTextField


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.height = tagHeight;
        self.font = tagFont;
        self.placeholder = @"多个标签用逗号或者换行隔开";
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
       
    }
    return self;
}

//监听键盘的删除按钮的点击
- (void)deleteBackward{
    !self.deleteBlock ? : self.deleteBlock();
    [super deleteBackward];
}

@end
