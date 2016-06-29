//
//  WJYRecommendedTagCell.h
//  百思不得姐
//
//  Created by fangjs on 16/6/20.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJYRecommendedTag.h"

static NSString * const recommandedTagCellId = @"recommandedTag";

@interface WJYRecommendedTagCell : UITableViewCell

/**数据模型*/
@property (copy , nonatomic)  WJYRecommendedTag *recommendedModel;

@end
