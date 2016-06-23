//
//  WJYMenuCell.m
//  百思不得姐
//
//  Created by fangjs on 16/6/16.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYMenuCell.h"

@interface WJYMenuCell ()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation WJYMenuCell

- (void)awakeFromNib {
    self.textLabel.font = [UIFont systemFontOfSize:15];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden = !selected;
    self.backgroundColor = selected ? [UIColor whiteColor]:RGBColor(223, 223, 223);
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor:RGBColor(78, 78, 78);
}

-(void)layoutSubviews {
    [super layoutSubviews];
    //调整 cell 内部的 textLabel 的位置和高度
    self.textLabel.y = 2;
    self.textLabel.height = self.height - 2 * self.textLabel.y;
}

-(void)setModel:(WJYMenuModel *)model {
    _model = model;
    self.textLabel.text = model.name;
}

@end
