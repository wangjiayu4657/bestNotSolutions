//
//  WJYPictureView.m
//  百思不得姐
//
//  Created by fangjs on 16/6/30.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYPictureViews.h"
#import "WJYTopicsModel.h"
#import "DALabeledCircularProgressView.h"
#import "WJYShowPictureViewController.h"

@interface WJYPictureViews ()
@property (weak, nonatomic) IBOutlet UIImageView *gifImage;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeLargeButton;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end


@implementation WJYPictureViews


+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.myImageView.userInteractionEnabled = YES;
    [self.myImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

//显示图片
- (void) showPicture {
    WJYShowPictureViewController *showPicture = [[WJYShowPictureViewController alloc] init];
    showPicture.topicModel = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

-(void)setTopicModel:(WJYTopicsModel *)topicModel {
    _topicModel = topicModel;
    //获取扩展名
    NSString *extensionStr = [topicModel.largeImage pathExtension];
    self.gifImage.hidden = ![extensionStr.lowercaseString isEqualToString:@"gif"];
    //点击查看按钮是否显示取决于图片是否为大图片,如果是大图的话就显示,否则隐藏
    self.seeLargeButton.hidden = !topicModel.isBigPicture;

    //设置进度条的值
    [self.progressView setProgress:topicModel.pictureProgress animated:NO];
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.largeImage] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        topicModel.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:topicModel.pictureProgress animated:NO];
        NSString *progressString = [NSString stringWithFormat:@"%.0f%%",topicModel.pictureProgress * 100];
        self.progressView.progressLabel.text = [progressString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        //如果不是大图的话直接返回
        if (topicModel.isBigPicture == NO) return;
        //开启图文上下文
        UIGraphicsBeginImageContextWithOptions(self.topicModel.pictureViewFrame.size, YES, 0.0);
        //图片的宽度和高度
        CGFloat pictureWidth = self.topicModel.width;
        CGFloat pictureHeight = self.topicModel.height;
        //按照等比例来计算imageView 控件的高度
        CGFloat myImageViewHeight = self.myImageView.width *  pictureHeight / pictureWidth;
        //将下载完的图片画到设置的区域内
        [image drawInRect:CGRectMake(0, 0, self.myImageView.width, myImageViewHeight)];
        //设置裁剪后的图片
        self.myImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
    }];
}


@end
