//
//  YYHDetailOfStoreFrame.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/12.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHDetailOfStoreFrame.h"
#import "NSString+JJ.h"

@implementation YYHDetailOfStoreFrame

- (void)setDetailStoreModel:(YYHDetailOfStoreModel *)detailStoreModel
{
    _detailStoreModel = detailStoreModel;
    
    CGSize instructionSize = [detailStoreModel.instruction sizeWithFont:[UIFont systemFontOfSize:15.0] maxSize:CGSizeMake(SYSTEM_WITH, MAXFLOAT)];
    _instructionFrame = CGRectMake(25, 235, instructionSize.width, instructionSize.height);
    
    CGSize addressSize = [detailStoreModel.storeAddress sizeWithFont:[UIFont systemFontOfSize:15.0] maxSize:CGSizeMake(SYSTEM_WITH, MAXFLOAT)];
    _addressFrame = CGRectMake(25, _instructionFrame.origin.y  + instructionSize.height + 10, addressSize.width, addressSize.height);
    
    _imageAndLabelHeight = (235 + _instructionFrame.size.height + 10 + _addressFrame.size.height + 10);
    
}

@end
