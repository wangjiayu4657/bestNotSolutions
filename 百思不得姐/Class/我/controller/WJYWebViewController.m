//
//  WJYWebViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/7/18.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYWebViewController.h"
#import <NJKWebViewProgress.h>

@interface WJYWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

/**进度条*/
@property (strong , nonatomic) NJKWebViewProgress *progress;

@end

@implementation WJYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    __weak typeof (self) weakSelf = self;
    self.progress.progressBlock = ^(float progress){
        NSLog(@"%f",progress);
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    self.progress.webViewProxyDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}



- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}

@end
