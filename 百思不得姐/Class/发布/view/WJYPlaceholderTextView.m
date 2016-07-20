//
//  WJYPlaceholderTextView.m
//  百思不得姐
//
//  Created by fangjs on 16/7/18.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYPlaceholderTextView.h"

@interface WJYPlaceholderTextView ()

/**占位符文字*/
@property (strong , nonatomic)  UILabel *placeholderLabel;

@end

@implementation WJYPlaceholderTextView

-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.x = 3;
        _placeholderLabel.y = 7;
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //默认字体大小
        self.font = [UIFont systemFontOfSize:15];
        //垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        //默认的占位文字颜色
        self.PlaceholderColor = [UIColor grayColor];
        //监听 textView 文字(内容)的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
/**
 *  监听文字改变
 */
- (void) textDidChange {
    //只要有文字,就隐藏占位文字 label
    self.placeholderLabel.hidden = self.hasText;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
     self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

#pragma mark - 重写 setter 方法

- (void)setPlaceholderColor:(UIColor *)PlaceholderColor {
    _PlaceholderColor = PlaceholderColor;
    self.placeholderLabel.textColor = PlaceholderColor;
}

- (void) setPlaceholder:(NSString *)Placeholder {
    _Placeholder = [Placeholder copy];
    self.placeholderLabel.text = Placeholder;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self textDidChange];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
