//
//  DATManager.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/20.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "DATManager.h"

@implementation DATManager

+ (instancetype)sharedDATManager
{
    static DATManager *_shareDATManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shareDATManager = [[self alloc] init];
        
    });
    
    return _shareDATManager;
}

- (instancetype)init
{
    if(self = [super init])
    {
        //创建数据库
        [[BaseDAT sharedBaseDAT] createDataBase];
        _detailModelDAT = [[DetailModelDAT alloc]init];
        _collectionModelDAT = [[CollectionModelDAT alloc]init];
    }
    return self;
}

@end
