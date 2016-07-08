//
//  WJYUser.h
//  百思不得姐
//
//  Created by fangjs on 16/7/7.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJYUser : NSObject

/** 用户名*/
@property (copy , nonatomic)  NSString *username;

/**性别*/
@property (copy , nonatomic)  NSString *sex;

/**用户头像*/
@property (copy , nonatomic)  NSString *profile_image;

@end
