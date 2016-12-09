//
//  YYHCollectionModelinDB.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/21.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBaseModel.h"

@interface YYHCollectionModelinDB : YYHBaseModel

@property(nonatomic,copy)NSString *storeName;
@property(nonatomic,copy)NSString *phoneHost;
@property(nonatomic,copy)NSString *instruction;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *key;
@property(nonatomic,copy)NSString *keyToDB;

@end
