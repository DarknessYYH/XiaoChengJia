//
//  YYHBaseModel.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBaseModel.h"

@implementation YYHBaseModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{

    if (self = [super init])
    {
        [self setKeyValues:dic];//使用了数据字典转模型数据的方法。方法封装好，方便使用
    }
    return self;
}


@end
