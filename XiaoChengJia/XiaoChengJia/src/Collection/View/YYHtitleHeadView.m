//
//  YYHtitleHeadView.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHtitleHeadView.h"
#import "UIImage+MJ.h"
#import "YYHHeadView.h"

@implementation YYHtitleHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        [self setImageview];
    }
    return  self;
}
- (void)setImageview
{
    self.image = [UIImage resizedImageWithName:@"timeline_card_top_background_line"];
    
    YYHHeadView *headView = [[YYHHeadView alloc] init];
    [headView setTitleColor:kColor(11, 100, 190) forState:UIControlStateNormal];
    headView.enabled = NO;
    self.headerViewButton = headView;
    [self addSubview:headView];
}

@end
