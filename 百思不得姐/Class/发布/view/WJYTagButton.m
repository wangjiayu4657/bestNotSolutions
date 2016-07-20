//
//  WJYTagButton.m
//  百思不得姐
//
//  Created by fangjs on 16/7/20.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTagButton.h"

@implementation WJYTagButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.backgroundColor = [UIColor colorWithRed:0.290 green:0.545 blue:0.820 alpha:1.000];
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3 * tagMargin;
    self.height = tagHeight;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.x = tagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + tagMargin;
}

@end
