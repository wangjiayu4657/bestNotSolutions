//
//  WJYCommentCell.h
//  百思不得姐
//
//  Created by fangjs on 16/7/12.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJYComment;

static NSString * const commentCellID = @"comment";


@interface WJYCommentCell : UITableViewCell

/**评论模型*/
@property (strong , nonatomic) WJYComment *comment;

@end
