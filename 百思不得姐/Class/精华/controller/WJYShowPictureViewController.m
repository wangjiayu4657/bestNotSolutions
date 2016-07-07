//
//  WJYShowPictureViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/6/30.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYShowPictureViewController.h"
#import "WJYTopicsModel.h"
#import <DALabeledCircularProgressView.h>


@interface WJYShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**imageView*/
@property (strong , nonatomic) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation WJYShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIDynamicAnimator;
    
    //获取图片的尺寸
    CGFloat pictureWidth = self.topicModel.width;
    CGFloat pictureHeight = self.topicModel.height;
    //计算 imageView控件的高度
    CGFloat imageViewHeith = screenWidth * pictureHeight / pictureWidth;
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.imageView];

    //设置进度条的值
    [self.progressView setProgress:self.topicModel.pictureProgress animated:YES];
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.largeImage] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",self.progressView.progress * 100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    if (imageViewHeith > screenHeight) { //如果图片的高度大于屏幕高度的话就设置图片显示的起始位置为:x:0 y:0
        self.imageView.frame = CGRectMake(0, 0, screenWidth, imageViewHeith);
        self.scrollView.contentSize = CGSizeMake(0, imageViewHeith);
    }else { //设置图片的显示位置在控制器 view 的中间即 screenHeight * 0.5
        self.imageView.size = CGSizeMake(screenWidth, imageViewHeith);
        self.imageView.centerY = screenHeight * 0.5;
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

@end
