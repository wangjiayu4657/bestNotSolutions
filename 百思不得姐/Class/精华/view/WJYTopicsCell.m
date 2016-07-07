//
//  WJYTopicsCell.m
//  百思不得姐
//
//  Created by fangjs on 16/6/24.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTopicsCell.h"
#import "WJYTopicsModel.h"
#import "WJYTopicPictureViews.h"
#import "WJYTopicVocieView.h"
#import "WJYTopicVideoViews.h"

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
@property (weak , nonatomic) WJYTopicPictureViews *pictureView;

/**voiceView*/
@property (weak , nonatomic) WJYTopicVocieView *voiceView;

/**voiceView*/
@property (weak , nonatomic) WJYTopicVideoViews *videoView;
@end


@implementation WJYTopicsCell

-(WJYTopicPictureViews *)pictureView{
    if (!_pictureView) {
        WJYTopicPictureViews *pictureView = [WJYTopicPictureViews pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

-(WJYTopicVocieView *)voiceView{
    if (!_voiceView) {
        WJYTopicVocieView *voiceView = [WJYTopicVocieView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

-(WJYTopicVideoViews *)videoView{
    if (!_videoView) {
        WJYTopicVideoViews *videoView = [WJYTopicVideoViews videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
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
    //是否需要显示 vip 标志
    self.isVipView.hidden = !topic.is_vip;
    
    [self.profieldImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    //帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    
    //帖子文字内容
    self.text_label.text = topic.text;

    [self setUpTitleOfButton:self.dingButton withCount:topic.ding withTitle:@"定"];
    [self setUpTitleOfButton:self.caiButton withCount:topic.cai withTitle:@"踩"];
    [self setUpTitleOfButton:self.shareButton withCount:topic.repost withTitle:@"分享"];
    [self setUpTitleOfButton:self.commentButton withCount:topic.comment withTitle:@"评论"];
    
    //cell根据类型的不同加载不同的内容
    if (topic.type == TopicTypePicture) {//图片
        self.pictureView.hidden = NO;
        self.pictureView.topicModel = topic;
        self.pictureView.frame = topic.pictureViewFrame;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == TopicTypeVoice) {//音频
        self.voiceView.hidden = NO;
        self.voiceView.topicModel = topic;
        self.voiceView.frame = topic.voiceViewFrame;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == TopicTypeVedio) {//视频
        self.videoView.hidden = NO;
        self.videoView.topicModel = topic;
        self.videoView.frame = topic.videoViewFrame;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }else {//帖子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
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
