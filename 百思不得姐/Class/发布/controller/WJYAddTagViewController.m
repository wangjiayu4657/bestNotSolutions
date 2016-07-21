//
//  WJYAddTagViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/7/19.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYAddTagViewController.h"
#import "WJYTagButton.h"
#import "WJYTagTextField.h"

@interface WJYAddTagViewController () <UITextFieldDelegate>

/**内容视图*/
@property (weak , nonatomic)  UIView *contentView;


/**输入文本框*/
@property (weak , nonatomic)   UITextField *textField;

/**添加标签按钮*/
@property (weak , nonatomic)  UIButton *addTagButton;

/**所有的标签按钮*/
@property (strong , nonatomic)  NSMutableArray *tagButtons;

@end

@implementation WJYAddTagViewController

#pragma mark - 懒加载

-(NSMutableArray *)tagButtons{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

-(UIButton *)addTagButton{
    if (!_addTagButton) {
        UIButton *addTagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addTagButton.backgroundColor = [UIColor colorWithRed:0.290 green:0.545 blue:0.820 alpha:1.000];
        addTagButton.titleLabel.font = tagFont;
        addTagButton.contentEdgeInsets = UIEdgeInsetsMake(0, tagMargin, 0, tagMargin);
        [addTagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addTagButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        //设置按钮内部的文字和图片左对齐
        addTagButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:addTagButton];
        _addTagButton = addTagButton;
    }
    return _addTagButton;
}

//设置容器 view
-(UIView *)contentView{
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        [self.view addSubview:contentView];
        self.contentView = contentView;
    }
    return _contentView;
}

//设置输入文本框
-(UITextField *)textField{
    if (!_textField) {
        __weak typeof (self) weakSelf = self;
        WJYTagTextField *textField = [[WJYTagTextField alloc] init];
        textField.delegate = self;
        textField.deleteBlock = ^{
            if (weakSelf.textField.hasText) return ;
            //如果 textfield的 text 为空则删除标签
            [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
        };
        
        [textField becomeFirstResponder];
        [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:textField];
        self.textField = textField;
    }
    return _textField;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    //设置导航
    [self setupNav];
    //设置容器 view
//    [self setupContentView];
    //设置输入文本框
//    [self setupTextField];
    
   
}

//设置导航栏
- (void) setupNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加标签";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"style:UIBarButtonItemStyleDone target:self action:@selector(finished)];
}

//设置导航
//- (void) setupContentView {
//    UIView *contentView = [[UIView alloc] init];
//    
//    contentView.x = tagMargin;
//    contentView.y = 64 + tagMargin;
//    contentView.width = self.view.width - 2 * contentView.x;
//    contentView.height = self.view.height;
//    
//    [self.view addSubview:contentView];
//     self.contentView = contentView;
//}

//设置输入文本框
//- (void)setupTextField {
//    
//    __weak typeof (self) weakSelf = self;
//    WJYTagTextField *textField = [[WJYTagTextField alloc] init];
//    textField.width = self.contentView.width - 2 * tagMargin;
//    textField.x = tagMargin;
//    textField.delegate = self;
//    textField.deleteBlock = ^{
//        if (weakSelf.textField.hasText) return ;
//        //如果 textfield的 text 为空则删除标签
//        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
//    };
//
//    [textField becomeFirstResponder];
//    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
//    [self.contentView addSubview:textField];
//    self.textField = textField;
//}

- (void)setupTags {
    //确保只调用一次
    if (self.tags.count) {
        for (NSString *text in self.tags) {
            self.textField.text = text;
            [self addButtonClick];
        }
        self.tags = nil;
    }
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //布局容器 view
    self.contentView.x = tagMargin;
    self.contentView.y = 64 + tagMargin;
    self.contentView.width = self.view.width - 2 * self.contentView.x;
    self.contentView.height = self.view.height;
    
    //布局容器 输入文本框
    self.textField.x = tagMargin;
    self.textField.width = self.contentView.width - 2 * tagMargin;
    
    //布局添加标签按钮
    self.addTagButton.height = 35;
    self.addTagButton.width = self.contentView.width;
    
    //设置标签
     [self setupTags];
}

#pragma mark - 监听文字的改变
//监听文字改变
- (void) textDidChange {
    if ([self.textField hasText]) {//如果有文字
        self.addTagButton.hidden = NO;
        self.addTagButton.y = CGRectGetMaxY(self.textField.frame) + tagMargin;
        [self.addTagButton setTitle:[NSString stringWithFormat:@"添加标签: %@",self.textField.text] forState:UIControlStateNormal];
        
        //获取最后一个字符
        NSString *text = self.textField.text;
        NSUInteger length = self.textField.text.length;
        NSString *lastLetter = [text substringFromIndex:length - 1];
        if ([lastLetter isEqualToString:@","] || [lastLetter isEqualToString:@"，"]) {
            self.textField.text = [text substringToIndex:length - 1];
            [self addButtonClick];
        }
        
    }else {//如果没有文字
        self.addTagButton.hidden = YES;
    }
     //时时更新标签按钮的 frame
     [self updateTextfieldFrame];
}

#pragma mark - 按钮的点击事件

//取消
- (void) cancle {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//完成
- (void) finished  {
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock ? :self.tagsBlock(tags);
    [self.navigationController popViewControllerAnimated:YES];
}

//监听'添加按钮'点击事件
- (void) addButtonClick {
    
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    //添加'标签按钮'
    WJYTagButton *tagButton = [WJYTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    //清空 textfield 的文字
    self.textField.text = nil;
    self.addTagButton.hidden = YES;
    
    //更新标签按钮的 frame
    [self updateTagButtonFrame];
    [self updateTextfieldFrame];

}

// 点击标签按钮的响应事件
- (void) tagButtonClick:(WJYTagButton *) tagButton {
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    //更新所有标签按钮的 frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextfieldFrame];
    }];
}

#pragma mark - 子控件 frame 的处理

//更新标签按钮的 frame
- (void) updateTagButtonFrame {
    for (int i = 0; i < self.tagButtons.count; i++) {
        WJYTagButton *tagButton = self.tagButtons[i];
        if (i == 0) {//第一个按钮
            tagButton.x = 0;
            tagButton.y = 0;
        }else {//上一个按钮
            WJYTagButton *previousButton = self.tagButtons[i - 1];
            //左边距离 = 上一个按钮的最大 x 值 + tagMargin
            CGFloat leftWidth = CGRectGetMaxX(previousButton.frame) + tagMargin;
            //右边剩余距离
            CGFloat rightWidth = self.contentView.width - leftWidth;  
            if (rightWidth >= tagButton.width) {
                tagButton.x = leftWidth;
                tagButton.y = previousButton.y;
            }else {
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(previousButton.frame) + tagMargin;
            }
        }
    }
}

//更新 textfield 的 frame
- (void) updateTextfieldFrame {
    WJYTagButton *lastButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + tagMargin;
    CGFloat rightWidth = self.contentView.width - leftWidth;
    if (rightWidth >= [self textFieldTextWidth]) {
        self.textField.x = leftWidth;
        self.textField.y = lastButton.y;
    }else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastButton.frame) + tagMargin;
    }
}

//计算 textfield 文字的宽度
- (CGFloat)textFieldTextWidth {
    CGFloat textWidth = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    return MAX(100, textWidth);
}

#pragma mark - <UITextFieldDelegate>

//监听键盘最右下角的换行的点击(比如:完成,GO等等)
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}





@end
