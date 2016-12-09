//
//  YYHBaseButton.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/3.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBaseButton.h"

@implementation YYHBaseButton

- (instancetype)initWithType:(BaseButtonType)type
{
    if (self=[super init])
    {
        self.baseButtonType = type;
    }
    return self;
}

- (void)layoutSubviews//重写子类按钮的子控件的布局
{
    [super layoutSubviews];  //重写父类都需要先初始化父类的方法
    
    if (self.baseButtonType == BaseButtonTypeCenter)
    {
        //设置按钮的图片位置,如果图片没有就使用origin point
        CGPoint center = self.imageView.center;
        center.x = self.width/2;
        center.y = self.imageView.height/2;
        self.imageView.center = center;
        //设置title的属性
        CGRect frame = [self titleLabel].frame;
        frame.origin.x = 0;
        frame.origin.y = self.imageView.height + 5;
        frame.size.width = self.width;
        self.titleLabel.frame = frame;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor blackColor];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    }
    
}

@end
