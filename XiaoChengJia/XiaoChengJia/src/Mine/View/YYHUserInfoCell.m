//
//  YYHUserInfoCell.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/31.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHUserInfoCell.h"
#import "WBaccountTool.h"

@implementation YYHUserInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupCell];
    }
    return self;
}

- (void)setupCell
{
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(20, 10, 50, 40);
    _cellImage = imageView;
    [self.contentView addSubview:imageView];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(imageView.frame.origin.x + imageView.width + 20, imageView.center.y - 10, 100, 20);
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    titleLabel.textColor = [UIColor lightGrayColor];
    _cellLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
}

@end
