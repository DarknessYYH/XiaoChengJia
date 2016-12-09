//
//  YYHDetailStoreCell.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/7.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHDetailStoreCell.h"
#import "UIImageView+WebCache.h"
#import "cellCommon.h"
#import "UIImage+MJ.h"

@implementation YYHDetailStoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupCell];
  
    }
    return self;
}

- (void)setDetailStoreFrame:(YYHDetailOfStoreFrame *)detailStoreFrame
{
    _detailStoreFrame = detailStoreFrame;
    //设置商家图片
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:_detailStoreFrame.detailStoreModel.imageURL]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize)
    {
    }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
    {
    if(image && finished)
    {
        self.storeImage.image = image;
    }
    }];
    //设置商家的名称，详情，地址
    self.storeName.text = _detailStoreFrame.detailStoreModel.storeName;
    _storeInstruction.frame = detailStoreFrame.instructionFrame;
    _storeInstruction.text = detailStoreFrame.detailStoreModel.instruction;
    _storeInstructionIcon.frame = CGRectMake(10, _storeInstruction.y + 2, 15, 15);
    _storeInstructionIcon.image = [UIImage imageNamed:@"instruction"];

    _storeAddress.frame = detailStoreFrame.addressFrame;
    _storeAddress.text = detailStoreFrame.detailStoreModel.storeAddress;
    _storeAddressIcon.frame = CGRectMake(10, _storeAddress.y, 15, 15);
    _storeAddressIcon.image = [UIImage imageNamed:@"maps-1"];
    
    //按钮
    self.collectBtn = [self addBtnWithTitle:@"收藏" image:@"timeline_icon_unlike_os7" bImage:@"timeline_card_leftbottom_highlighted_os7" index:0];
    [self.collectBtn addTarget:self action:@selector(clickCollection:) forControlEvents:UIControlEventTouchUpInside];
    
    self.commentBtn = [self addBtnWithTitle:@"评论" image:@"timeline_icon_comment_os7" bImage:@"timeline_card_middlebottom_highlighted_os7" index:1];
    [self.commentBtn addTarget:self action:@selector(clickComment:) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareBtn = [self addBtnWithTitle:@"分享" image:@"timeline_icon_retweet_os7" bImage:@"timeline_card_rightbottom_highlighted_os7" index:2];
    [self.shareBtn addTarget:self action:@selector(clickShare:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加分割线
    UIImageView *divider1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted_os7"]];
    divider1.frame = CGRectMake(10, self.collectBtn.y - 1, self.width - 10, 1);
    [self.contentView addSubview:divider1];
    
    self.detailStoreCellHeight = self.detailStoreFrame.imageAndLabelHeight + 80 ;
}

- (void)setupCell
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 195)];
    _storeImage = imageView;
    [self.contentView addSubview:imageView];
    
    //名称
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, self.width, 15)];
    name.font = [UIFont systemFontOfSize:20.0];
    _storeName = name;
    [self.contentView addSubview:name];
    
    //电话
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 70, 210, 60, 70)];
    [btn setImage:[UIImage imageNamed:@"about_phone_icon"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_middlebottom_highlighted_os7"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(clickPhone:) forControlEvents:UIControlEventTouchUpInside];
    _phoneBtn = btn;
    [self.contentView addSubview:btn];
    //划线
    UIImageView *divider2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted_os7_H"]];
    divider2.frame = CGRectMake(self.phoneBtn.x , 220, 1, 50);
    [self.contentView addSubview:divider2];

    //详情
    UILabel *instruction = [[UILabel alloc] init];
    instruction.font = [UIFont systemFontOfSize:15.0];
    [instruction setTextColor:[UIColor grayColor]];
    instruction.numberOfLines = 0;
    self.storeInstruction = instruction;
    [self.contentView addSubview:instruction];
    
    UIImageView *instructionIcon = [[UIImageView alloc] init];
    _storeInstructionIcon = instructionIcon;
    [self.contentView addSubview:instructionIcon];
    //地址
    UILabel *adderss = [[UILabel alloc] init];
    adderss.font = [UIFont systemFontOfSize:15.0];
    [adderss setTextColor:[UIColor grayColor]];
    adderss.numberOfLines = 0;
    self.storeAddress = adderss;
    [self.contentView addSubview:adderss];
    
    UIImageView *addressIcon = [[UIImageView alloc] init];
    _storeAddressIcon = addressIcon;
    [self.contentView addSubview:addressIcon];
}

- (UIButton *)addBtnWithTitle:(NSString *)title image:(NSString *)image bImage:(NSString *)bImage  index:(int)index
{
    UIButton * btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kColor(71, 151, 71) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn setBackgroundImage:[UIImage imageNamed:bImage] forState:UIControlStateHighlighted];
    //调整按钮控件中图片与文字之间的间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    int i = index % 3;
    int with = self.width / 3;
    
    btn.frame = CGRectMake(i * with, _detailStoreFrame.imageAndLabelHeight + 20, with, 50);
    [self.contentView addSubview:btn];
    
    return btn;
}

- (void)addBlock:(ButtonBlock)commentBlock phoneBlock:(ButtonBlock)phoneBlock
 collectionBlock:(ButtonBlock)collectionBlock shareBlock:(ButtonBlock)shareBlock
{
    self.commentBlock = commentBlock;
    self.phoneBlock = phoneBlock;
    self.collectionBlock = collectionBlock;
    self.shareBlock = shareBlock;
}

- (void)clickComment:(id)sender
{
    if (self.commentBlock)
    {
        self.commentBlock(sender);
    }
}

- (void)clickPhone:(id)sender
{
    if (self.phoneBlock)
    {
        self.phoneBlock(sender);
    }
}

- (void)clickCollection:(id)sender
{
    if (self.collectionBlock)
    {
        self.collectionBlock(sender);
    }
}

- (void)clickShare:(id)sender
{
    if (self.shareBlock)
    {
        self.shareBlock(sender);
    }
}

@end
