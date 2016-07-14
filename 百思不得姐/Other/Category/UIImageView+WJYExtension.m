//
//  UIImageView+WJYExtension.m
//  百思不得姐
//
//  Created by fangjs on 16/7/14.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "UIImageView+WJYExtension.h"

@implementation UIImageView (WJYExtension)

-(void)setHeaderImageView:(NSString *) url {
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];

}
@end
