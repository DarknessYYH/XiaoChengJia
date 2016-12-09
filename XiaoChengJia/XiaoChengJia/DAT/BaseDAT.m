//
//  BaseDAT.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/20.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "BaseDAT.h"

@implementation BaseDAT

+ (instancetype)sharedBaseDAT
{
    static BaseDAT *_shareBaseDAT = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shareBaseDAT = [[self alloc] init];
    });
    
    return _shareBaseDAT;
}

- (instancetype)init
{
    if(self = [super init])
    {
        _dbQueue = [[FMDatabaseQueue alloc]initWithPath:[BaseDAT GetDataBasePath]];
    }
    return self;
}

//获取数据库的本地路径
+ (NSString *)GetDataBasePath
{
    NSString *documentPath =
    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dataBasePath = [documentPath stringByAppendingPathComponent:@"Y.sqlite"];
    return dataBasePath;
}

//创建数据库
- (void)createDataBase
{
    if (!self.XCJDB) {
        NSString *dataBasePath = [BaseDAT GetDataBasePath];
        self.XCJDB = [FMDatabase databaseWithPath:dataBasePath];
    }
}

//判断表是否存在
- (BOOL)hasTableWithName:(NSString *)tableName
{
    [self openDataBase];
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) as 'count' FROM sqlite_master where type='table' and name='%@'",tableName];
    FMResultSet * rs =[self.XCJDB executeQuery:sql];
    int count = 0;
    while ([rs next])
    {
        count = [rs intForColumn:@"count"];
        
        [self closeDataBase];
        
        if (count == 0)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}

//打开数据库
- (FMDatabase *)openDataBase
{
    if(!self.XCJDB)
    {
        [self createDataBase];
    }
    if (![self.XCJDB open])
    {
        @throw @"db open error";
    }
    return self.XCJDB;
}

//关闭数据库
- (void)closeDataBase
{
    if(self.XCJDB)
        [self.XCJDB close];
}


@end
