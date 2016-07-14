//
//  UIImage+WJYExtension.m
//  百思不得姐
//
//  Created by fangjs on 16/7/14.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "UIImage+WJYExtension.h"

@implementation UIImage (WJYExtension)

- (UIImage *) circleImage {
    //NO : 透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //获取上下文
    CGContextRef contex = UIGraphicsGetCurrentContext();
    //设置原形区域
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(contex, rect);
    //裁剪
    CGContextClip(contex);
    //将裁剪后的图片画上去
    [self drawInRect:rect];
    //获取处理完的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
