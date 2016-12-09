//
//  YYHCollectionFrame.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBaseModel.h"
#import "YYHCollectionModelinDB.h"

@interface YYHCollectionFrame : YYHBaseModel

@property(nonatomic,strong)YYHCollectionModelinDB *inDBModel;
@property(nonatomic,assign,readonly)CGFloat cellHeight;
@property(nonatomic,assign,readonly)CGRect  instructionFrame;
@property(nonatomic,assign,readonly)CGRect  addressFrame;

@end
