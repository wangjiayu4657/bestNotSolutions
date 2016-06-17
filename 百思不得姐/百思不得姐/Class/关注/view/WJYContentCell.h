//
//  WJYContentCell.h
//  百思不得姐
//
//  Created by fangjs on 16/6/16.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJYContentModel.h"

static NSString * const contentCellID = @"contentCell";

@interface WJYContentCell : UITableViewCell

/** 数据模型*/
@property (strong , nonatomic) WJYContentModel *contentModel;

@end
