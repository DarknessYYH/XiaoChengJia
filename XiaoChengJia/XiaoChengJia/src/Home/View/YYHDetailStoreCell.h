//
//  YYHDetailStoreCell.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/7.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHDetailOfStoreFrame.h"

typedef void(^ButtonBlock)(id sender);

@interface YYHDetailStoreCell : UITableViewCell <UIActionSheetDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)YYHDetailOfStoreFrame *detailStoreFrame;
@property(nonatomic,strong)ButtonBlock commentBlock;
@property(nonatomic,strong)ButtonBlock phoneBlock;
@property(nonatomic,strong)ButtonBlock collectionBlock;
@property(nonatomic,strong)ButtonBlock shareBlock;
@property(nonatomic,weak)UIImageView *storeImage;
@property(nonatomic,weak)UILabel *storeName;
@property(nonatomic,weak)UILabel  *storeInstruction;
@property(nonatomic,weak)UILabel *storeAddress;
@property(nonatomic,weak)UIImageView *storeInstructionIcon;
@property(nonatomic,weak)UIImageView *storeAddressIcon;//地址图标

@property(nonatomic,weak)UIButton *collectBtn;
@property(nonatomic,weak)UIButton *commentBtn;
@property(nonatomic,weak)UIButton *shareBtn;
@property(nonatomic,weak)UIButton *phoneBtn;

@property(nonatomic,assign)CGFloat detailStoreCellHeight;

- (UIButton *)addBtnWithTitle:(NSString *)title image:(NSString *)image bImage:(NSString *)bImage index:(int)index;
- (void)addBlock:(ButtonBlock)commentBlock phoneBlock:(ButtonBlock)phoneBlock
 collectionBlock:(ButtonBlock)collectionBlock shareBlock:(ButtonBlock)shareBlock;

@end
