//
//  WJYAddTagViewController.h
//  百思不得姐
//
//  Created by fangjs on 16/7/19.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJYAddTagViewController : UIViewController

/**所有的标签文字*/
@property (strong , nonatomic)  void (^tagsBlock)(NSArray *tags);

/**标签内容*/
@property (strong , nonatomic)  NSArray *tags;

@end
