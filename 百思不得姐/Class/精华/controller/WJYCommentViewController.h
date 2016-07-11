//
//  WJYCommentViewController.h
//  百思不得姐
//
//  Created by fangjs on 16/7/11.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJYTopicsModel;

@interface WJYCommentViewController : UIViewController

/**帖子数据模型*/
@property (strong , nonatomic)  WJYTopicsModel *topicModel;

@end
