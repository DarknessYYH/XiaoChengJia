//
//  YYHCollectionFrame.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHCollectionFrame.h"
#import "NSString+JJ.h"

@implementation YYHCollectionFrame

- (void)setInDBModel:(YYHCollectionModelinDB *)inDBModel
{
    _inDBModel = inDBModel;
    
    CGSize instructionSize = [inDBModel.instruction sizeWithFont:[UIFont systemFontOfSize:13.0]
                                                         maxSize:CGSizeMake(SCREEN_WIDTH - 80, MAXFLOAT)];
    _instructionFrame = CGRectMake(25, 40, instructionSize.width, instructionSize.height);
    
    CGSize addressSize = [inDBModel.address sizeWithFont:[UIFont systemFontOfSize:13.0]
                                                 maxSize:CGSizeMake(SCREEN_WIDTH - 80, MAXFLOAT)];
    _addressFrame = CGRectMake(25, _instructionFrame.origin.y + _instructionFrame.size.height + 10, addressSize.width, addressSize.height);
    
    _cellHeight = 55 + _instructionFrame.size.height + _addressFrame.size.height ;
}

@end
