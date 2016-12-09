//
//  YYHNavigationCell.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/2.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHNavigationCell.h"
#import "YYHBaseButton.h"
#import "UIImage+MJ.h"

@implementation YYHNavigationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self addAllButton];
    }
    return self;
}



- (void)addAllButton
{
    [self addbtn:@"宵夜外卖" icon:@"header_button_1" index:0];
    [self addbtn:@"出行包车" icon:@"header_button_2" index:1];
    [self addbtn:@"休闲娱乐" icon:@"header_button_3" index:2];
    [self addbtn:@"餐饮美食" icon:@"header_button_4" index:3];
    [self addbtn:@"快递物流" icon:@"header_button_5" index:4];
    [self addbtn:@"服装相关" icon:@"header_button_6" index:5];
    [self addbtn:@"家居装修" icon:@"header_button_7" index:6];
    [self addbtn:@"驾校学车" icon:@"header_button_8" index:7];
    [self addbtn:@"横幅海报" icon:@"header_button_9" index:8];
    [self addbtn:@"蛋糕定制" icon:@"header_button_10" index:9];
    [self addbtn:@"周边住宿" icon:@"header_button_11" index:10];
    [self addbtn:@"其他" icon:@"header_button_12" index:11];
}

- (UIButton *)addbtn:(NSString *)title icon:(NSString *)icon index:(int)index
{
    YYHBaseButton *btn = [[YYHBaseButton alloc] initWithType:BaseButtonTypeCenter];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn.enabled = YES;
    
    int i = index / 4;
    int j = index % 4;
    CGFloat height = 70;
    CGFloat with = self.width / 4;
    btn.tag = index;//用于标记按钮的分类
    btn.frame = CGRectMake(with * j, height * i + 5, with, height);
    [self.contentView addSubview:btn];
    [btn addTarget:self action:@selector(setDapaidang:) forControlEvents:UIControlEventTouchUpInside];
    
    return  btn;
}

- (void)setDapaidang:(UIButton *)sender
{
    if (self.iconBlock)
    {
        self.iconBlock(sender);
    }
}

- (void)addBlock:(setIconBlock)block
{
    self.iconBlock = block;
}



@end
