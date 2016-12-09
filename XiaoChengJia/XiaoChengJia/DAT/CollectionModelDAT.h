//
//  CollectionModelDAT.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/21.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAT.h"
#import "YYHCollectionModelinDB.h"

@interface CollectionModelDAT : NSObject

-(void)createTable;
- (void)insert:(YYHCollectionModelinDB *)info;
- (BOOL)isExistEntity:(YYHCollectionModelinDB *)info;
- (NSArray *)getAll;
- (void)deleteAll;
- (void)deleteCollectionModel:(id)key property:(id)property;
+ (NSMutableArray *)queryCollectionModelWithWhere:(id)key property:(id)property;
@end
