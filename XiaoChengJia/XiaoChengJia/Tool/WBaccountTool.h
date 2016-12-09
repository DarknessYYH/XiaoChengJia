//
//  WBaccountTool.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/17.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYHAccountModel.h"

#define WB_ACCOUNT_FILE_PATH   [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.arch"]

@interface WBaccountTool : NSObject

+ (void)saveAccount:(YYHAccountModel *)account;
+ (YYHAccountModel *)account;

@end
