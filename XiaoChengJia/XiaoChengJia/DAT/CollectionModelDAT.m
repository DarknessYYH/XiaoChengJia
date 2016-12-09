//
//  CollectionModelDAT.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/21.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "CollectionModelDAT.h"
#define CollectionDAT @"CollectionDAT"

@implementation CollectionModelDAT

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
    
    if(![[BaseDAT sharedBaseDAT].XCJDB tableExists:CollectionDAT])
    {
        NSString *sql = [NSString stringWithFormat:@"create table %@ (storeName Text,phoneHost Text,instruction Text,address Text,key Text,keyToDB Text)",CollectionDAT];
        BOOL success = [[BaseDAT sharedBaseDAT].XCJDB executeUpdate:sql];
        if(success)
        {
            YLog(@"创建%@成功",CollectionDAT);
        }
        else
        {
            YLog(@"创建%@失败",CollectionDAT);
        }
    }
    [[BaseDAT sharedBaseDAT] closeDataBase];
    
}

//判断表中是否存在某一对象
- (BOOL)isExistEntity:(YYHCollectionModelinDB *)info
{
    int count = 0;
    NSArray *allAata = [NSArray arrayWithArray:[self getAll]];
    for (YYHCollectionModelinDB *collection in allAata)
    {
        BOOL yi = [collection.storeName isEqualToString:info.storeName];
        count += yi;
    }
    return count;
}

//(插入/更新)对象到数据库
- (void)insert:(YYHCollectionModelinDB *)info
{
    YYHCollectionModelinDB *entity = info;
    
    //插入记录
    NSString *insertSql = [NSString stringWithFormat:@"insert into %@ (storeName, phoneHost, instruction,address,key,keyToDB) values(?,?,?,?,?,?)",CollectionDAT];
    //更新指定typestoreName列
    NSString *upSql = [NSString stringWithFormat:@"update %@ set  phoneHost=? instruction=? , address=? , key=? , keyToDB=?  where storeName=?",CollectionDAT];
    
    //多线程中使用队列执行sql 避免数据混乱
    [[BaseDAT sharedBaseDAT].dbQueue inDatabase:^(FMDatabase *db)
    {
        if(![self isExistEntity:info])
        {//不存在插入对象
            
            [db executeUpdate:insertSql,entity.storeName,entity.phoneHost,entity.instruction,entity.address,entity.key,entity.keyToDB];
        }
        else
        {//存在，更新对象的值
            
            [db executeUpdate:upSql,entity.storeName,entity.phoneHost,entity.instruction,entity.address,entity.key,entity.keyToDB];
        }
        
    }];
   
}

//查询数据库 通过storeName排序 （DESC：逆序排序 ASC：顺序排序）
- (NSArray *)getAll
{
    NSMutableArray *resultArr = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"select *from %@ order by storeName",CollectionDAT];
    [[BaseDAT sharedBaseDAT] openDataBase];
    FMResultSet *s = [[BaseDAT sharedBaseDAT].XCJDB executeQuery:sql];
    while ([s next])
    {
        YYHCollectionModelinDB *entity = [[YYHCollectionModelinDB alloc]init];
        entity.storeName = [s stringForColumn:@"storeName"];
        entity.phoneHost = [s stringForColumn:@"phoneHost"];
        entity.instruction = [s stringForColumn:@"instruction"];
        entity.address = [s stringForColumn:@"address"];
        entity.key = [s stringForColumn:@"key"];
        entity.keyToDB = [s stringForColumn:@"keyToDB"];
        [resultArr addObject:entity];
    }
    [[BaseDAT sharedBaseDAT] closeDataBase];
    return resultArr;
}

//删除数据库所有对象
- (void)deleteAll
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@",CollectionDAT];
   
    [[BaseDAT sharedBaseDAT].dbQueue inDatabase:^(FMDatabase *db)
    {
        [db executeUpdate:sql];
    }];
    
}
- (void)deleteCollectionModel:(id)key property:(id)property
{
    [[BaseDAT sharedBaseDAT] openDataBase];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ where %@ = '%@'",CollectionDAT
                     ,key,property];
    
    [[BaseDAT sharedBaseDAT].dbQueue inDatabase:^(FMDatabase *db)
    {
        [db executeUpdate:sql];
    }];
    [[BaseDAT sharedBaseDAT] closeDataBase];
    
}


+ (NSMutableArray *)queryCollectionModelWithWhere:(id)key property:(id)property
{
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM %@ where %@ = '%@'",CollectionDAT,key,property];
    NSMutableArray *resultArr = [NSMutableArray array];
    [[BaseDAT sharedBaseDAT] openDataBase];

    FMResultSet *s = [[BaseDAT sharedBaseDAT].XCJDB executeQuery:sql];
    while ([s next])
    {
        YYHCollectionModelinDB *entity = [[YYHCollectionModelinDB alloc]init];
        entity.storeName = [s stringForColumn:@"storeName"];
        entity.phoneHost = [s stringForColumn:@"phoneHost"];
        entity.instruction = [s stringForColumn:@"instruction"];
        entity.address = [s stringForColumn:@"address"];
        entity.key = [s stringForColumn:@"key"];
        entity.keyToDB = [s stringForColumn:@"keyToDB"];
        [resultArr addObject:entity];
    }
    [[BaseDAT sharedBaseDAT] closeDataBase];
    return resultArr;

}



@end
