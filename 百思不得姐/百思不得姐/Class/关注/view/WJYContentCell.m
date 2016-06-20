//
//  WJYContentCell.m
//  百思不得姐
//
//  Created by fangjs on 16/6/16.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYContentCell.h"

@interface WJYContentCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation WJYContentCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setContentModel:(WJYContentModel *)contentModel {
    _contentModel = contentModel;
    
    self.screenNameLabel.text = contentModel.screen_name;
    NSString *count = nil;
    if (contentModel.fans_count < 10000) {
        count = [NSString stringWithFormat:@"%zd人关注",contentModel.fans_count];
    }else {
        count = [NSString stringWithFormat:@"%.1f万人关注",contentModel.fans_count / 10000.0];
    }
    self.fansCountLabel.text = count;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:contentModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}

@end
