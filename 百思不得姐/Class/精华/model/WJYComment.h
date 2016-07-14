//
//  WJYComment.h
//  百思不得姐
//
//  Created by fangjs on 16/7/7.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WJYUser;

@interface WJYComment : NSObject

/**id*/
@property (copy , nonatomic)  NSString *ID;

/**音频文件的时长*/
@property (assign , nonatomic)  NSInteger voicetime;

/**音频文件的地址*/
@property (copy , nonatomic)  NSString *voiceuri;

/**被点赞的数量*/
@property (assign , nonatomic) NSInteger like_count;

/**评论的内容*/
@property (copy , nonatomic)  NSString *content;

/**用户模型*/
@property (strong , nonatomic)  WJYUser *user;
@end
