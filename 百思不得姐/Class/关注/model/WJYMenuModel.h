//
//  WJYModel.h
//  百思不得姐
//
//  Created by fangjs on 16/6/15.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJYMenuModel : NSObject

/**id*/
@property (assign , nonatomic) NSInteger ID;
/**数量*/
@property (assign , nonatomic) NSInteger count;
/**名称*/
@property (strong , nonatomic) NSString *name;

/**这个类别对应的用户数据*/
@property (strong , nonatomic)  NSMutableArray *users;

/**总页数*/
@property (assign , nonatomic)  NSInteger total;

/**当前页*/
@property (assign , nonatomic)  NSInteger currentPage;

@end
