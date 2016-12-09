//
//  UIImage+Fit.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/7.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "UIImage+Fit.h"

@implementation UIImage (Fit)

-(UIImage *)resizeImage
{
    CGFloat leftCap = self.size.width * 0.5f;
    CGFloat topCap = self.size.height * 0.5f;
    return  [self stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

+(UIImage *)resizeImage:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] resizeImage];
}

@end
