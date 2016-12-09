//
//  BaseDAT.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/20.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface BaseDAT : NSObject

@property (nonatomic, strong) FMDatabase *XCJDB;
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

+ (instancetype)sharedBaseDAT;

//创建数据库
- (void)createDataBase;

//获取数据库本地路径
+ (NSString *)GetDataBasePath;

//判断表是否存在
- (BOOL)hasTableWithName:(NSString *)tableName;

//打开数据库
- (FMDatabase *)openDataBase;

//关闭数据库
- (void)closeDataBase;

@end
