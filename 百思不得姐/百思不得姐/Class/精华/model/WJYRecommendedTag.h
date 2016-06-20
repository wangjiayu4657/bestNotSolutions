//
//  WJYRecommendedTag.h
//  百思不得姐
//
//  Created by fangjs on 16/6/20.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJYRecommendedTag : NSObject

/**图片地址*/
@property (copy , nonatomic)  NSString *image_list;
/**名字*/
@property (copy , nonatomic)  NSString *theme_name;
/**订阅数*/
@property (assign , nonatomic) NSInteger sub_number;

@end
