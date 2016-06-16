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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentModel:(WJYContentModel *)contentModel {
    _contentModel = contentModel;
    
    self.screenNameLabel.text = contentModel.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",contentModel.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:contentModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}

@end
