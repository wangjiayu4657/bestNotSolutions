//
//  WJYTopicsModel.h
//  百思不得姐
//
//  Created by fangjs on 16/6/24.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJYTopicsModel : NSObject

/**发帖者的头像*/
@property (copy , nonatomic)  NSString *profile_image;

/**帖子的文字内容*/
@property (copy , nonatomic)  NSString *text;

/**发帖者名称*/
@property (copy , nonatomic)  NSString *name;

/**发帖时间*/
@property (copy , nonatomic)  NSString *create_time;

/**顶贴数量*/
@property (assign , nonatomic)  NSInteger ding;

/**踩贴数量*/
@property (assign , nonatomic) NSInteger cai;

/**帖子的评论数量*/
@property (assign , nonatomic)  NSInteger comment;

/**帖子的转发量*/
@property (assign , nonatomic)  NSInteger repost;

/**是否为会员*/
@property (assign , nonatomic , getter=is_vip)  BOOL is_vip;

@end
