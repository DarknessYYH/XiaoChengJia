//
//  YYHBusinessAPITool.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBusinessAPITool.h"
#import "YYHBusinessModel.h"
#import "YYHDetailOfStoreModel.h"
#import "YYHCommentModel.h"

@implementation YYHBusinessAPITool

+(void)getAllBusiness:(NSString *)uid
              success:(HttpSuccessBlock)success
              failure:(HttpFailureBlock)failure
{
    [HttpTool getWithPath:uid params:nil success:^(id result)
    {
        if (!result)
        {
            success (nil);
            return;
        }
        NSArray * busArray = result[@"results"];//AVOS的返回确定的key== results;
        NSMutableArray * arrayM = [NSMutableArray array];
        for (NSDictionary * dic in busArray)
        {
            YYHDetailOfStoreModel * bM=[[YYHDetailOfStoreModel alloc]initWithDictionary:dic];
            [arrayM addObject:bM];
        }
        success(arrayM);
    }
    failure:^(NSError *error)
    {
        failure(error);
    }];
}

+(void)postAllBUsindess:(NSString *)className
                params:(NSDictionary *)params
                success:(HttpSuccessBlock)success
                failure:(HttpFailureBlock)failure{
    NSString *postPath = [[NSString alloc] initWithFormat:@"classes/%@",className];
    
    [HttpTool postWithPath:postPath params:params success:^(id result)
    {
        if (!result)
        {
            success(nil);
            return;
        }
        success(result);
    }
    failure:^(NSError *error)
    {
        failure(error);
    }];
}

+(void)getAllBusinessWithCommentModel:(NSString *)uid
              success:(HttpSuccessBlock)success
              failure:(HttpFailureBlock)failure{
    [HttpTool getWithPath:uid params:nil success:^(id result)
    {
        if (!result)
        {
            success (nil);
            return;
        }
        NSArray * busArray = result[@"results"];//AVOS的返回确定的key== results;
        NSMutableArray * arrayM = [NSMutableArray array];
        for (NSDictionary * dic in busArray)
        {
            YYHCommentModel * bM=[[YYHCommentModel alloc] initWithDictionary:dic];
            [arrayM addObject:bM];
        }
        success(arrayM);
    }
    failure:^(NSError *error)
    {
        failure(error);
    }];
}


@end


