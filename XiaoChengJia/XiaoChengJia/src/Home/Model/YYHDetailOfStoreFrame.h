//
//  YYHDetailOfStoreFrame.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/12.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBaseModel.h"
#include "YYHDetailOfStoreModel.h"

@interface YYHDetailOfStoreFrame : YYHBaseModel
@property(nonatomic,strong) YYHDetailOfStoreModel *detailStoreModel;
@property(nonatomic,assign,readonly) CGFloat imageAndLabelHeight;
@property(nonatomic,assign,readonly) CGRect  instructionFrame;
@property(nonatomic,assign,readonly) CGRect  addressFrame;


@end
