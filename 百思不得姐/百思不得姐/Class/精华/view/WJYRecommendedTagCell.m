//
//  WJYRecommendedTagCell.m
//  百思不得姐
//
//  Created by fangjs on 16/6/20.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYRecommendedTagCell.h"


@interface WJYRecommendedTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;


@end

@implementation WJYRecommendedTagCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setRecommendedModel:(WJYRecommendedTag *)recommendedModel {
    _recommendedModel = recommendedModel;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendedModel.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendedModel.theme_name;
    NSString *subNumber = nil;
    if (recommendedModel.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommendedModel.sub_number];
    }else {
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",recommendedModel.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

//通过改变 cell frame 来实现分割线和左右留白的效果
- (void)setFrame:(CGRect)frame {
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
