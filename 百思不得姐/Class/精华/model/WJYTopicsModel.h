//
//  WJYTopicsModel.h
//  百思不得姐
//
//  Created by fangjs on 16/6/24.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJYComment;

@interface WJYTopicsModel : NSObject

/**id*/
@property (copy , nonatomic) NSString *ID;

/**发帖者的头像*/
@property (copy , nonatomic)  NSString *profile_image;

/**帖子的文字内容*/
@property (copy , nonatomic)  NSString *text;

/**发帖者名称*/
@property (copy , nonatomic)  NSString *name;

/**发帖时间*/
@property (copy , nonatomic)  NSString *create_time;

/**顶贴数量*/
@property (assign , nonatomic)  NSInteger ding;

/**踩贴数量*/
@property (assign , nonatomic) NSInteger cai;

/**帖子的评论数量*/
@property (assign , nonatomic)  NSInteger comment;

/**帖子的转发量*/
@property (assign , nonatomic)  NSInteger repost;

/**是否为会员*/
@property (assign , nonatomic , getter=is_vip)  BOOL is_vip;

/**帖子类型*/
@property (assign , readonly , nonatomic)  CGFloat type;

/**小图片*/
@property (copy , nonatomic) NSString *smallImage;

/**中图片*/
@property (copy , nonatomic) NSString *middleImage;

/**大图片*/
@property (copy , nonatomic) NSString *largeImage;

/**图片的高度*/
@property (assign , nonatomic)  NSInteger height;

/**图片的宽度*/
@property (assign , nonatomic)  NSInteger width;

/**音频时长*/
@property (assign , nonatomic)  NSInteger voicetime;

/**视频时长*/
@property (assign , nonatomic)  NSInteger videotime;

/**播放次数*/
@property (assign , nonatomic)  NSInteger playcount;

/**音频资源地址*/
@property (copy , nonatomic)  NSString *voiceuri;

/**视频资源地址*/
@property (copy , nonatomic)  NSString *videouri;

/**最热评论*/
@property (strong , nonatomic)  WJYComment *top_cmt;


/***************************** 添加额外的副主属性 *******************************/

/**cell 的高度*/
@property (assign , readonly , nonatomic)  CGFloat cellHeight;

/**图片帖子控件的Frame*/
@property (assign , readonly , nonatomic)  CGRect pictureViewFrame;

/**是否为大图的标志*/
@property (assign , nonatomic , getter=isBigPicture) BOOL isBigPicture;

/**图片的下载进度*/
@property (assign , nonatomic)  CGFloat pictureProgress;


/**音频帖子控件的Frame*/
@property (assign , readonly , nonatomic)  CGRect voiceViewFrame;

/**视频帖子控件的Frame*/
@property (assign , readonly , nonatomic)  CGRect videoViewFrame;

@end
