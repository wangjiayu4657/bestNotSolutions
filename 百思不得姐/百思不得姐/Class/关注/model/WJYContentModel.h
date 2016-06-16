//
//  WJYContentModel.h
//  百思不得姐
//
//  Created by fangjs on 16/6/16.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJYContentModel : NSObject
/**粉丝*/
@property (assign , nonatomic) NSInteger fans_count;

/**头像地址*/
@property (copy , nonatomic) NSString *header;

/**昵称*/
@property (copy , nonatomic) NSString *screen_name;


@end
