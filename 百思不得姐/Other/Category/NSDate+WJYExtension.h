//
//  NSDate+WJYExtension.h
//  百思不得姐
//
//  Created by fangjs on 16/6/28.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WJYExtension)

/**
 *  比较两个时间的差值
 *
 *  @param date 需要比较的时间
 *
 *  @return NSDateComponents
 */
- (NSDateComponents *) componentFromDate:(NSDate *) date;


/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
@end
