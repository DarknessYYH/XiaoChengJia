//
//  YYHBuinessHeadView.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/22.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBuinessHeadView.h"

@implementation YYHBuinessHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setImage:[UIImage imageNamed:@"hotStore"] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return  CGRectMake(10, 5, 30, 30);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(45, 12.5, 60, 15);
}

@end
