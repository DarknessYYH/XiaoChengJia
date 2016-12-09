//
//  YYHCommentFrame.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/7.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHCommentFrame.h"
#import "NSString+JJ.h"
#import "cellCommon.h"

#define COMMENT_LABEL_FONTSIZE  13.0
#define COMMENT_LABEL_BOARDER_X  15.0  // 保持与cell的分组title的位置对齐z
#define COMMENT_LABEL_BOARDER_Y  35.0

@implementation YYHCommentFrame

- (void)setCommmentModel:(YYHCommentModel *)commmentModel
{
    _commmentModel = commmentModel;
  
    CGSize textSize = [commmentModel.comment sizeWithFont:[UIFont systemFontOfSize:FONTSIZE] maxSize:CGSizeMake(SCREEN_WIDTH - 10, MAXFLOAT)];
    _commentLabelFrame = CGRectMake(COMMENT_LABEL_BOARDER_X, COMMENT_LABEL_BOARDER_Y, textSize.width, textSize.height);
    _CellHeight = (textSize.height + COMMENT_LABEL_BOARDER_Y + COMMENTBOAR_Y + 20);
}
@end
