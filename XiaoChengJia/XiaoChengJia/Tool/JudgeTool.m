//
//  JudgeTool.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "JudgeTool.h"

@implementation JudgeTool
+(BOOL)isEmptyArray:(NSArray *)array
{
    if (array == nil || [array isKindOfClass:[NSNull class]] ||array.count == 0)
    {
        return YES;
    }
    return NO;
}
@end
