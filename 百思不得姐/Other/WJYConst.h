#import <UIKit/UIKit.h>

typedef enum{
    TopicTypeAll = 1,
    TopicTypePicture = 10,
    TopicTypeWord = 29,
    TopicTypeVoice = 31,
    TopicTypeVedio = 41
}TopicType ;

/** 精华 - 顶部所有标题的高度*/
UIKIT_EXTERN CGFloat const titleViewHeight;

/** 精华 - 顶部所有标题的Y*/
UIKIT_EXTERN CGFloat const titleViewY;

/** 精华 - cell - 间距*/
UIKIT_EXTERN CGFloat const topicCellMargin;

/** 精华 - cell - 底部工具条的高度*/
UIKIT_EXTERN CGFloat const topicCellBottomBarHeight;

/** 精华 - cell - 文字内容的 Y*/
UIKIT_EXTERN CGFloat const topicCellTextY;

/** 精华 - cell - 最大图片的高度*/
UIKIT_EXTERN CGFloat const topicMaxPictureHeight;

/** 精华 - cell - 一旦图片的高度大于最大高度的话就设为topicPictureBreakHeight*/
UIKIT_EXTERN CGFloat const topicPictureBreakHeight;


/**WJYUser 模型中 性别的属性值*/
UIKIT_EXTERN  NSString * const WJYUserSexMale;
UIKIT_EXTERN  NSString * const WJYUserSexFemale;





