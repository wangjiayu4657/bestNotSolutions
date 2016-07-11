//
//  WJYTopicsCell.h
//  百思不得姐
//
//  Created by fangjs on 16/6/24.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJYTopicsModel;


static NSString *const topicCellID = @"topic";

@interface WJYTopicsCell : UITableViewCell

/**数据模型*/
@property (strong , nonatomic)  WJYTopicsModel *topic;

+ (instancetype) cell;

@end
