//
//  NSString+Expand.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/7/26.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "NSString+Expand.h"

@implementation NSString (Expand)

//判断字符串是否为空
+ (BOOL)isEmptyString:(NSString *)string
{
    if(!string || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || string.length == 0)
    {
        return YES;
    }
    return NO;
}

@end
