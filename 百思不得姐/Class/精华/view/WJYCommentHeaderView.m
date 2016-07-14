//
//  WJYCommentHeaderView.m
//  百思不得姐
//
//  Created by fangjs on 16/7/11.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYCommentHeaderView.h"

static NSString *headID = @"headerView";


@interface WJYCommentHeaderView()
/**标题*/
@property (weak , nonatomic) UILabel *label;

@end


@implementation WJYCommentHeaderView

+(instancetype)headerViewWithTableView:(UITableView *)tableView {
    WJYCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headID];
    if (header == nil) {
        header = [[WJYCommentHeaderView alloc]initWithReuseIdentifier:headID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = GlobalColor;
        UILabel *label = [[UILabel alloc] init];
        label.width = 200;
        label.x = topicCellMargin;
        label.font = [UIFont systemFontOfSize:15];
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.textColor = RGBColor(67, 67, 67);
        self.label = label;
        [self.contentView addSubview:label];
    }
    return self;
}

-(void)setTitle:(NSString *)title {
    _title = [title copy];
    self.label.text = title;
}



@end
