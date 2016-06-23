//
//  WJYTextField.m
//  百思不得姐
//
//  Created by fangjs on 16/6/21.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTextField.h"
#import <objc/runtime.h>

@implementation WJYTextField

//+(void)initialize {
//    unsigned int count = 0;
//    //获取一个类的所有成员变量列表,返回值是一个指向数组的指针
//    Ivar *ivarList = class_copyIvarList([UITextField class], &count);
//    //遍历数组,取出每一个成员变量的名称
//    for (unsigned int i = 0; i < count; i++) {
//        Ivar ivar = *(ivarList + i);
//        NSLog(@"成员变量: %s",ivar_getName(ivar));
//    }
//    //释放
//    free(ivarList);
//}

- (void)awakeFromNib {
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder {
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

-  (BOOL)resignFirstResponder {
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}


@end
