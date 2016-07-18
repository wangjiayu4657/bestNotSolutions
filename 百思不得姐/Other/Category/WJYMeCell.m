//
//  WJYMeCell.m
//  百思不得姐
//
//  Created by fangjs on 16/7/15.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYMeCell.h"
#import "WJYSquareModel.h"

@implementation WJYMeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgImageView;
  
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)layoutSubviews {
   [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + topicCellMargin;
}

@end
