//
//  NSDate+WJYExtension.m
//  百思不得姐
//
//  Created by fangjs on 16/6/28.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "NSDate+WJYExtension.h"

@implementation NSDate (WJYExtension)

- (NSDateComponents *)componentFromDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:date toDate:self options:0];
}


-(BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger currentDate = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfDate = [calendar component:NSCalendarUnitYear fromDate:self];
    return currentDate == selfDate;
}

-(BOOL)isToday {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    NSString *selfDate = [formatter stringFromDate:self];
    
    return [currentDate isEqualToString:selfDate];
}

-(BOOL)isYesterday {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *currentDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [formatter dateFromString:[formatter stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unit fromDate:selfDate toDate:currentDate options:0];
    
    return components.year == 0 && components.month == 0 && components.day == 1;
}

@end
