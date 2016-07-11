//
//  WJYCommentHeaderView.h
//  百思不得姐
//
//  Created by fangjs on 16/7/11.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJYCommentHeaderView : UITableViewHeaderFooterView

+(instancetype) headerViewWithTableView:(UITableView *) tableView;

/**标题*/
@property (copy , nonatomic)  NSString *title;

@end
