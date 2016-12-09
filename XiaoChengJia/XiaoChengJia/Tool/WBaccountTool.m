//
//  WBaccountTool.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/17.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "WBaccountTool.h"

@implementation WBaccountTool

+ (void)saveAccount:(YYHAccountModel *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:WB_ACCOUNT_FILE_PATH];
}

+ (YYHAccountModel *)account
{
    YYHAccountModel * account = [NSKeyedUnarchiver unarchiveObjectWithFile:WB_ACCOUNT_FILE_PATH];
    return account == nil ? nil : account;
}

@end
