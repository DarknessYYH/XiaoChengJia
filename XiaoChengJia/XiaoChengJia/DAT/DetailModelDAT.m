//
//  DetailModelDAT.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/20.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "DetailModelDAT.h"
#define DetailModelTable @"DetailModelDAT"
@implementation DetailModelDAT

-(instancetype)init
{
    if(self = [super init])
    {
        [self createTable];
    }
    return self;
}

//创建表
-(void)createTable
{
    [[BaseDAT sharedBaseDAT] openDataBase];
    
    if(![[BaseDAT sharedBaseDAT].XCJDB tableExists:DetailModelTable])
    {
        NSString *sql = [NSString stringWithFormat:@"create table %@ (storeName Text,storeAddress Text,phoneHost Text,instruction Text,key Text,keyToDB Text,imageName Text,imageURL Text,commentClassName Text)",DetailModelTable];
        BOOL success = [[BaseDAT sharedBaseDAT].XCJDB executeUpdate:sql];
        if(success)
        {
            YLog(@"创建%@成功",DetailModelTable);
        }
        else
        {
            YLog(@"创建%@失败",DetailModelTable);
        }
    }
    [[BaseDAT sharedBaseDAT] closeDataBase];
    
}

//通过对象中的唯一键值 判断表中是否存在该对象
- (BOOL)isExistEntity:(YYHDetailOfStoreModel *)info db:(FMDatabase *)db
{
    NSString *sql = [NSString stringWithFormat:@"select count(storeName) from %@ where storeName=?",DetailModelTable];
    int count = [db intForQuery:sql,info.storeName];
    if(count > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//(插入/更新)对象到数据库
- (void)insert:(YYHDetailOfStoreModel *)info
{

    YYHDetailOfStoreModel *entity = info;
    //插入记录
    NSString *insertSql = [NSString stringWithFormat:@"insert into %@ (storeName, storeAddress, phoneHost, instruction,key,keyToDB,imageName,imageURL,commentClassName) values(?,?,?,?,?,?,?,?,?)",DetailModelTable];
    //更新指定typestoreName列
    NSString *upSql = [NSString stringWithFormat:@"update %@ set storeAddress=?, phoneHost=? instruction=?,key=?, keyToDB=? imageName=?,imageURL=?, commentClassName=? where storeName=?",DetailModelTable];
    
    //多线程中使用队列执行sql 避免数据混乱
    [[BaseDAT sharedBaseDAT].dbQueue inDatabase:^(FMDatabase *db) {
        
        if(![self isExistEntity:info db:db])
        {//不存在插入对象
            [db executeUpdate:insertSql,entity.storeName,entity.storeAddress,entity.phoneHost,entity.instruction,entity.key,entity.keyToDB,entity.imageName,entity.imageURL,entity.commentClassName];
        }
        else
        {//存在，更新对象的值
            [db executeUpdate:upSql,entity.storeName,entity.storeAddress,entity.phoneHost,entity.instruction,entity.key,entity.keyToDB,entity.imageName,entity.imageURL,entity.commentClassName];
        }
        
    }];
}

//查询数据库 通过storeName排序 （DESC：逆序排序 ASC：顺序排序）
- (NSArray *)getAll
{
    [[BaseDAT sharedBaseDAT] openDataBase];
    NSMutableArray *resultArr = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"select *from %@ order by storeName",DetailModelTable];
    FMResultSet *s = [[BaseDAT sharedBaseDAT].XCJDB executeQuery:sql];
    while ([s next]) {
        YYHDetailOfStoreModel *entity = [[YYHDetailOfStoreModel alloc]init];
        entity.storeName = [s stringForColumn:@"storeName"];
        entity.storeAddress = [s stringForColumn:@"storeAddress"];
        entity.phoneHost = [s stringForColumn:@"phoneHost"];
        entity.instruction = [s stringForColumn:@"instruction"];
        entity.key = [s stringForColumn:@"key"];
        entity.keyToDB = [s stringForColumn:@"keyToDB"];
        entity.imageName = [s stringForColumn:@"imageName"];
        entity.imageURL = [s stringForColumn:@"imageURL"];
        entity.commentClassName = [s stringForColumn:@"commentClassName"];
        [resultArr addObject:entity];
    }
    [[BaseDAT sharedBaseDAT] closeDataBase];
    return resultArr;
}

//删除数据库所有对象
- (void)deleteAll
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@",DetailModelTable];
    [[BaseDAT sharedBaseDAT] openDataBase];
    [[BaseDAT sharedBaseDAT].dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql];
    }];
    [[BaseDAT sharedBaseDAT] closeDataBase];
}

@end
