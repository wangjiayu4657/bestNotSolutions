//
//  WJYCommentCell.m
//  百思不得姐
//
//  Created by fangjs on 16/7/12.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYCommentCell.h"
#import "WJYComment.h"
#import "WJYUser.h"


@interface WJYCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation WJYCommentCell

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

- (void)awakeFromNib {
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgImageView;
}

-(void)setComment:(WJYComment *)comment {
    _comment = comment;
    
    self.contentLabel.text = self.comment.content;
    self.usernameLabel.text = self.comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",self.comment.like_count];
    //设置头像
    [self.profileImageView setHeaderImageView:self.comment.user.profile_image];
    self.sexView.image = [self.comment.user.sex isEqualToString:WJYUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    
    if (self.comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",self.comment.voicetime] forState:UIControlStateNormal];
    }else {
        self.voiceButton.hidden = YES;
    }
}

-(void)setFrame:(CGRect)frame {
    frame.origin.x = topicCellMargin;
    frame.size.width -= 2 * topicCellMargin;
    [super setFrame:frame];
}





@end
