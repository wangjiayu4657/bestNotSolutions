//
//  WJYPictureView.h
//  百思不得姐
//
//  Created by fangjs on 16/6/30.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJYTopicsModel;

@interface WJYTopicPictureViews : UIView

/**数据模型*/
@property (strong , nonatomic)  WJYTopicsModel *topicModel;


+ (instancetype) pictureView;

@end
