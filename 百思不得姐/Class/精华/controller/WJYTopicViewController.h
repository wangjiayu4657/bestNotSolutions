//
//  WJYTopicViewController.h
//  百思不得姐
//
//  Created by fangjs on 16/6/28.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    TopicTypeAll = 1,
    TopicTypePicture = 10,
    TopicTypeWord = 29,
    TopicTypeVoice = 31,
    TopicTypeVedio = 41
}TopicType ;

@interface WJYTopicViewController : UITableViewController

/**帖子类型*/
@property (assign , nonatomic)  TopicType type;

@end
