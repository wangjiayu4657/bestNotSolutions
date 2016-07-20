//
//  WJYTagTextField.h
//  百思不得姐
//
//  Created by fangjs on 16/7/20.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJYTagTextField : UITextField


/**键盘上的删除按钮*/
@property (strong , nonatomic) void (^deleteBlock)();

@end
