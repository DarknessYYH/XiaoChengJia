//
//  YYHStoreCell.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/29.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYHDetailOfStoreFrame.h"

@interface YYHStoreCell : UITableViewCell

@property(nonatomic,strong)YYHDetailOfStoreFrame * detailOfStoreFrame;
@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;

+ (instancetype)instanceWithXib;

@end
