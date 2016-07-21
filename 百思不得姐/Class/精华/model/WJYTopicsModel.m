//
//  WJYTopicsModel.m
//  百思不得姐
//
//  Created by fangjs on 16/6/24.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTopicsModel.h"
#import "WJYComment.h"
#import "WJYUser.h"

@implementation WJYTopicsModel
{
    CGFloat _cellHeight;
//    CGRect _pictureViewFrame;
}

//将请求参数中对应的key转换成模型中对应的key(模型中的key 与请求返回数据中的 key 不同时)
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"smallImage":@"image0",
             @"largeImage":@"image1",
             @"middleImage":@"image2",
             @"ID" : @"id",
             @"top_cmt":@"top_cmt[0]"
             };
}

//将数组转换成模型
//+ (NSDictionary *)mj_objectClassInArray {
//    return @{ @"top_cmt" : @"WJYComment"};
//}

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
        
        CGFloat ViweX = topicCellMargin;
        CGFloat ViewY = textHeight + topicCellTextY + topicCellMargin;
        CGFloat ViewW = maxSize.width;
        CGFloat ViewH = ViewW * self.height / self.width;

        
        if (self.type == TopicTypePicture) {//图片帖子控件的高度
            if (self.width != 0 && self.height != 0) {
                if (ViewH > topicMaxPictureHeight) {
                    ViewH = topicPictureBreakHeight;
                    self.isBigPicture = YES;
                }
                _pictureViewFrame = CGRectMake(ViweX, ViewY, ViewW, ViewH);
                _cellHeight += ViewH + topicCellMargin;
            }
        }else if (self.type == TopicTypeVoice) {//音频帖子控件的高度
             _voiceViewFrame =  CGRectMake(ViweX, ViewY, ViewW, ViewH);
             _cellHeight += ViewH + topicCellMargin;
            
        }else if (self.type == TopicTypeVedio) {//视频帖子控件的高度
             _videoViewFrame =  CGRectMake(ViweX, ViewY, ViewW, ViewH);
             _cellHeight += ViewH + topicCellMargin;
        }

        //最热评论

        if (self.top_cmt) {//如果最热评论有值则进行计算评论文字内容的高度
             NSString *content = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username,self.top_cmt.content];
             CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += topicCellCommentTitleHeight + contentH + topicCellMargin;
        }
      
         //最后在加上底部工具条的高度就是 cell 的高度
         _cellHeight += topicCellBottomBarHeight + topicCellMargin;
    }
   
    return _cellHeight;
}



@end
