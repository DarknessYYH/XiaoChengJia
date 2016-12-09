//
//  YYHCollectionCell.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYHCollectionFrame.h"

@interface YYHCollectionCell : UITableViewCell


typedef void(^ButtonBlock)(id sender);

@property(nonatomic,strong)ButtonBlock phoneButtonBlock;
@property(nonatomic,strong)YYHCollectionFrame *storeFrame;
@property(nonatomic,weak)UILabel *storeNameLabel;
@property(nonatomic,weak)UILabel *storeInstructionLabel;
@property(nonatomic,weak)UILabel *storeAddesssLabel;
@property(nonatomic,weak)UIButton *storePhoneButton;
@property(nonatomic,weak)UIImageView *addressDot;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)addBlockForPhoneButton:(ButtonBlock)block;

@end
