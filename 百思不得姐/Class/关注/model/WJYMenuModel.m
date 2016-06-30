//
//  WJYModel.m
//  百思不得姐
//
//  Created by fangjs on 16/6/15.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYMenuModel.h"

@implementation WJYMenuModel

-(NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

+(NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"ID"]) return @"id";
    return propertyName;
}

@end
