//
//  YYHHeadView.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHHeadView.h"

@implementation YYHHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up_os7"] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(10, 17.5, 15, 15);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(35, 17.5,150, 15);
}


@end
