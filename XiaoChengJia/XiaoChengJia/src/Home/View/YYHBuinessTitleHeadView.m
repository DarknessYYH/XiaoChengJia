//
//  YYHBuinessTitleHeadView.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/22.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBuinessTitleHeadView.h"

@implementation YYHBuinessTitleHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = NO;
        [self setImageview];
    }
    return  self;
}
- (void)setImageview
{
    [self setBackgroundColor:kColor(0xeb, 0xeb, 0xeb)];
    YYHBuinessHeadView *headView = [[YYHBuinessHeadView alloc] init];
    headView.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [headView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [headView setTitle:@"热门商家" forState:UIControlStateNormal];
    headView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    headView.enabled = NO;
    self.headerViewButton = headView;
    [self addSubview:headView];
}

@end
