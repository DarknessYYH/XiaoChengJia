//
//  YYHBusinessAPITool.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpTool.h"

@interface YYHBusinessAPITool : NSObject

+(void)getAllBusiness:(NSString *)uid
              success:(HttpSuccessBlock)success
              failure:(HttpFailureBlock)failure;

+(void)getAllBusinessWithCommentModel:(NSString *)uid
                              success:(HttpSuccessBlock)success
                              failure:(HttpFailureBlock)failure;

@end
