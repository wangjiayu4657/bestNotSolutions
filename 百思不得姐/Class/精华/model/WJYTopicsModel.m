//
//  WJYTopicsModel.m
//  百思不得姐
//
//  Created by fangjs on 16/6/24.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTopicsModel.h"

@implementation WJYTopicsModel
{
    CGFloat _cellHeight;
//    CGRect _pictureViewFrame;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"smallImage":@"image0",
             @"largeImage":@"image1",
             @"middleImage":@"image2"
             };
}


-(NSString *)create_time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [NSDate date];
    if (date.isThisYear) {//今年
        if (date.isToday) {//今天
            NSDateComponents *components = [date componentFromDate:[formatter dateFromString:_create_time]];
            if (components.hour > 1) {//时间差距 > 1小时
                return [NSString stringWithFormat:@"%zd小时前",components.hour];
            }else if (components.minute > 1){//时间差距 > 1分钟
                return [NSString stringWithFormat:@"%zd分钟前",components.minute];
            }else {
                return @"刚刚";
            }
        }else if (date.isYesterday) {//昨天
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:date];
        }else {
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:date];
        }
    }else {//非今年
        return _create_time;
    }
    
}

-(CGFloat)cellHeight {
  
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * topicCellMargin, MAXFLOAT);
        //文字内容的高度
        CGFloat textHeight = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
       _cellHeight = textHeight + topicCellTextY + topicCellMargin;
        
        if (self.type == TopicTypePicture) {
            CGFloat pictureViweX = topicCellMargin;
            //图片的Y值
            CGFloat pictureViewY = textHeight + topicCellTextY + topicCellMargin;
            CGFloat pictureViewW = maxSize.width;
            CGFloat pictureViewH = pictureViewW * self.height / self.width;
            if (pictureViewH > topicMaxPictureHeight) {
                pictureViewH = topicPictureBreakHeight;
                self.isBigPicture = YES;
            }
            _pictureViewFrame = CGRectMake(pictureViweX, pictureViewY, pictureViewW, pictureViewH);
            _cellHeight += pictureViewH + topicCellMargin;
        }
         //最后在加上底部工具条的高度就是 cell 的高度
         _cellHeight += topicCellBottomBarHeight + topicCellMargin;
    }
   
    return _cellHeight;
}



@end
