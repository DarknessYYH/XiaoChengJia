//
//  DetailModelDAT.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/20.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAT.h"
#import "YYHDetailOfStoreModel.h"

@interface DetailModelDAT : NSObject
-(void)createTable;
- (void)insert:(YYHDetailOfStoreModel *)info;
- (BOOL)isExistEntity:(YYHDetailOfStoreModel *)info db:(FMDatabase *)db;
- (NSArray *)getAll;
- (void)deleteAll;

@end
