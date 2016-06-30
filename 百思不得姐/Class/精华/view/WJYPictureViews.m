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

- (void) showPicture {
    WJYShowPictureViewController *showPicture = [[WJYShowPictureViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

-(void)setTopicModel:(WJYTopicsModel *)topicModel {
    _topicModel = topicModel;
    NSString *extensionStr = [topicModel.largeImage pathExtension];
    self.gifImage.hidden = ![extensionStr.lowercaseString isEqualToString:@"gif"];

    self.seeLargeButton.hidden = !topicModel.isBigPicture;
    if (topicModel.isBigPicture) {
        self.myImageView.contentMode = UIViewContentModeScaleAspectFill;
    }else {
        self.myImageView.contentMode = UIViewContentModeScaleToFill;
    }

    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.largeImage] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:progress];
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
}


@end
