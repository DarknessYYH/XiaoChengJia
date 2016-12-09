//
//  YYHStoreCell.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/29.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHStoreCell.h"
#import "HttpTool.h"
#import "UIImageView+WebCache.h"

@implementation YYHStoreCell


- (void)setDetailOfStoreFrame:(YYHDetailOfStoreFrame *)detailOfStoreFrame
{
    _detailOfStoreFrame = detailOfStoreFrame;
    self.nameLabel.text = detailOfStoreFrame.detailStoreModel.storeName;
    self.phoneLabel.text = detailOfStoreFrame.detailStoreModel.phoneHost;
    self.instructionLabel.text = detailOfStoreFrame.detailStoreModel.instruction;

    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:detailOfStoreFrame.detailStoreModel.imageURL]
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
}


+ (instancetype)instanceWithXib
{

    return [[[NSBundle mainBundle] loadNibNamed:@"YYHStoreCell" owner:nil options:nil] lastObject];
}

@end
