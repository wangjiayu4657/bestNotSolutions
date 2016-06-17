//
//  WJYMenuCell.h
//  百思不得姐
//
//  Created by fangjs on 16/6/16.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJYMenuModel.h"

static NSString * const menuCellID = @"menuCell";

@interface WJYMenuCell : UITableViewCell

/**数据模型*/
@property (strong , nonatomic) WJYMenuModel *model;

//- (void) cellWithModel:(WJYModel *) model;

@end
