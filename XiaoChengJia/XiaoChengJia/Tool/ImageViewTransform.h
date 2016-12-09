//
//  ImageViewTransform.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/1.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageViewTransform : NSObject

+ (void)imageViewRotateAnimation:(UIImageView *)currentImg;
+ (void)imageViewRotateAnimation:(UIImageView *)currentImg from:(id)fromValue
                              to:(id)toValue duration:(CFTimeInterval)duration;
@end
