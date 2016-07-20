//
//  WJYPostWordViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/7/18.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYPostWordViewController.h"
#import "WJYPlaceholderTextView.h"
#import "WJYAddTagToolbar.h"



@interface WJYPostWordViewController () <UITextViewDelegate>

@property (weak , nonatomic) WJYPlaceholderTextView *placeholderTextView;
/**工具条*/
@property (weak , nonatomic)  WJYAddTagToolbar *toolbar;

@end

@implementation WJYPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    [self setupTextView];
    [self setupToolbar];

}

- (void)viewDidAppear:(BOOL)animated {
    [self.placeholderTextView becomeFirstResponder];
}

//设置导航栏
- (void) setupNav {
    self.navigationItem.title = @"发表文字";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;//一进来'发表'默认为不能点击
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateDisabled];
    //要改变rightBarButtonItem的颜色状态必须要强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}

//设置输入文本框
- (void) setupTextView {
    WJYPlaceholderTextView *placeholderTextView = [[WJYPlaceholderTextView alloc] init];
    placeholderTextView.frame = self.view.bounds;
    placeholderTextView.delegate = self;
    [placeholderTextView becomeFirstResponder];
    placeholderTextView.Placeholder = @"把好玩的图片,好笑的段子或糗事发到这里,接受千万网友膜拜吧!发布违反国家法律内容的,我们将依法提交给有关部门处理";
    [self.view addSubview:placeholderTextView];
    self.placeholderTextView = placeholderTextView;
    
}
//设置工具栏
- (void) setupToolbar {
    WJYAddTagToolbar *toolbar = [WJYAddTagToolbar viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//监听键盘的弹出
- (void) keyboardFrameChanged:(NSNotification *) noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, rect.origin.y - screenHeight);
    }];
}

//取消按钮
- (void) cancle {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//发布按钮
- (void) post {
    NSLog(@"hahhah");
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
     self.navigationItem.rightBarButtonItem.enabled = self.placeholderTextView.hasText;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
