//
//  YYHLunBoCollectionViewCell.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHLunBoCollectionViewCell.h"

@implementation YYHLunBoCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupImageView];
        
    }
    return self;
}

-(void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    _imageView = imageView;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}


@end
