//
//  WJYAddTagToolbar.m
//  百思不得姐
//
//  Created by fangjs on 16/7/19.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYAddTagToolbar.h"
#import "WJYAddTagViewController.h"


@interface WJYAddTagToolbar()
@property (weak, nonatomic) IBOutlet UIView *topView;

/**所有的标签文字*/
@property (strong , nonatomic)  NSMutableArray *tagLabels;

/**添加按钮*/
@property (weak , nonatomic)  UIButton *addButton;

@end

@implementation WJYAddTagToolbar

-(NSMutableArray *)tagLabels{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib {
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    //设置按钮的尺寸为当前按钮上显示的图片的尺寸
    addButton.size = addButton.currentImage.size;
    addButton.x = tagMargin;
    
    [self.topView addSubview:addButton];
    self.addButton = addButton;
    
    [self createTagLabel:@[@"吐槽",@"糗事"]];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        //label 的位置
        if (i == 0) {//第一个按钮
            tagLabel.x = 0;
            tagLabel.y = 0;
        }else {//上一个按钮
            UILabel *previousLabel = self.tagLabels[i - 1];
            //左边距离 = 上一个按钮的最大 x 值 + tagMargin
            CGFloat leftWidth = CGRectGetMaxX(previousLabel.frame) + tagMargin;
            //右边剩余距离
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) {
                tagLabel.x = leftWidth;
                tagLabel.y = previousLabel.y;
            }else {
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(previousLabel.frame) + tagMargin;
            }
        }
    }
    
    UILabel *lastLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + tagMargin;
    CGFloat rightWidth = self.topView.width - leftWidth;
    if (rightWidth >= self.addButton.width) {
        self.addButton.x = leftWidth;
        self.addButton.y = lastLabel.y;
    }else {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastLabel.frame) + tagMargin;
    }
    
    //整体高度
    CGFloat oldHeight = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 45;
    self.y -= self.height - oldHeight;
}

- (void) addbuttonClick {
    
    WJYAddTagViewController *addTagController = [[WJYAddTagViewController alloc] init];
    __weak typeof (self) weakSelf = self;
    [addTagController setTagsBlock:^(NSArray *tags) {
        [weakSelf createTagLabel:tags];
    }];
     addTagController.tags = [self.tagLabels valueForKey:@"text"];
     UIViewController *controller = (UIViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
     UINavigationController *nav = (UINavigationController *) controller.presentedViewController;
    [nav pushViewController: addTagController animated:YES];
}

- (void) createTagLabel:(NSArray *) tags {
    //先清除
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        tagLabel.text = tags[i];
        tagLabel.font = tagFont;
        [tagLabel sizeToFit];
        tagLabel.width += 2 * tagMargin;
        tagLabel.height = tagHeight;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.backgroundColor = [UIColor colorWithRed:0.290 green:0.545 blue:0.820 alpha:1.000];
        [self.tagLabels addObject:tagLabel];
        [self.topView addSubview:tagLabel];
    }
    //重新布局子控件
    [self setNeedsLayout];
}



@end
