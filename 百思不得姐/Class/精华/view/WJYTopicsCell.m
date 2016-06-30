//
//  WJYTopicsCell.m
//  百思不得姐
//
//  Created by fangjs on 16/6/24.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTopicsCell.h"
#import "WJYTopicsModel.h"
#import "WJYPictureViews.h"

@interface WJYTopicsCell()
/** 图片*/
@property (weak, nonatomic) IBOutlet UIImageView *profieldImageView;
/** 昵称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间*/
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶按钮*/
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩按钮*/
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 转发按钮*/
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论按钮*/
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 关注按钮*/
@property (weak, nonatomic) IBOutlet UIButton *focusOnButton;
/** 新浪加 V 认证*/
@property (weak, nonatomic) IBOutlet UIImageView *isVipView;
/** 文字内容*/
@property (weak, nonatomic) IBOutlet UILabel *text_label;

/**pictureView*/
@property (weak , nonatomic) WJYPictureViews *pictureView;

@end


@implementation WJYTopicsCell


-(UIView *)pictureView{
    if (!_pictureView) {
        WJYPictureViews *pictureView = [WJYPictureViews pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setTopic:(WJYTopicsModel *)topic {
    _topic = topic;

    self.isVipView.hidden = !topic.is_vip;
    
    [self.profieldImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
   
    self.createTimeLabel.text = topic.create_time;
    
    //文字内容
    self.text_label.text = topic.text;

    [self setUpTitleOfButton:self.dingButton withCount:topic.ding withTitle:@"定"];
    [self setUpTitleOfButton:self.caiButton withCount:topic.cai withTitle:@"踩"];
    [self setUpTitleOfButton:self.shareButton withCount:topic.repost withTitle:@"分享"];
    [self setUpTitleOfButton:self.commentButton withCount:topic.comment withTitle:@"评论"];
    
    if (topic.type == TopicTypePicture) {
        self.pictureView.topicModel = topic;
        self.pictureView.frame = topic.pictureViewFrame;
    }
}

- (void) setUpTitleOfButton:(UIButton *)button  withCount:(NSInteger)count withTitle:(NSString *) title {
   if (count == 0) {
       
    }else  if (count > 10000) {
        title = [NSString stringWithFormat:@"%.f万",count / 10000.0];
    }else {
        title = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:title forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = topicCellMargin;
    frame.origin.y += topicCellMargin;
    frame.size.width -= 2 * topicCellMargin;
    frame.size.height -= topicCellMargin;
    
    [super setFrame:frame];
}


@end
