//
//  ImageViewTransform.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/1.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "ImageViewTransform.h"

@implementation ImageViewTransform

//图片旋转动画
+ (void)imageViewRotateAnimation:(UIImageView *)currentImg
{
    //围绕Z轴旋转，垂直与屏幕
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    animation.fromValue = @(0.0); // 设定动画起始帧和结束帧
    animation.toValue = @(M_PI/2);
    animation.duration = 0.5; //动画持续时间
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
   // animation.repeatCount = 1e100; //重复次数
    [currentImg.layer addAnimation:animation forKey:nil];
}

+ (void)imageViewRotateAnimation:(UIImageView *)currentImg
                            from:(id)fromValue
                              to:(id)toValue
                        duration:(CFTimeInterval)duration
{
    //围绕Z轴旋转，垂直与屏幕
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    animation.fromValue = fromValue; // 设定动画起始帧和结束帧
    animation.toValue = toValue;
    animation.duration = duration; //动画持续时间
    animation.cumulative = YES;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
     animation.repeatCount = 1; //重复次数
    [currentImg.layer addAnimation:animation forKey:nil];
}
@end
