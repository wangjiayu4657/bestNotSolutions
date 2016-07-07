//
//  WJYTopicVideoView.m
//  百思不得姐
//
//  Created by fangjs on 16/7/7.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTopicVideoViews.h"
#import "WJYTopicsModel.h"
#import "WJYShowPictureViewController.h"

@interface WJYTopicVideoViews()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation WJYTopicVideoViews

+ (instancetype) videoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

//显示图片
- (void) showPicture {
    WJYShowPictureViewController *showPicture = [[WJYShowPictureViewController alloc] init];
    showPicture.topicModel = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}
-(void)setTopicModel:(WJYTopicsModel *)topicModel {
    _topicModel = topicModel;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.largeImage]];

    //播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topicModel.playcount];
    
    //声音时长
    NSInteger minute = topicModel.voicetime / 60;
    NSInteger second = topicModel.voicetime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

//播放视频
- (IBAction)play:(id)sender {
    
}

@end
