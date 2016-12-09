//
//  YYHCommentFrame.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/7.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBaseModel.h"
#import "YYHCommentModel.h"

@interface YYHCommentFrame : YYHBaseModel

@property(nonatomic,strong)YYHCommentModel *commmentModel;
@property(nonatomic,assign,readonly)CGRect commentLabelFrame;
@property(nonatomic,assign,readonly)CGFloat CellHeight;

@end
