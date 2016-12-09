//
//  YYHDetailOfStoreModel.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/7.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBaseModel.h"

@interface YYHDetailOfStoreModel : YYHBaseModel

@property(nonatomic,copy)NSString *storeName;
@property(nonatomic,copy)NSString *storeAddress;
@property(nonatomic,copy)NSString *phoneHost;
@property(nonatomic,copy)NSString *instruction;
@property(nonatomic,copy)NSString *key;    //用于本地热门商家查询以及本地储存
@property(nonatomic,copy)NSString *keyToDB;//用于常规分类商家的本地储存
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *imageURL;
@property(nonatomic,copy)NSString *commentClassName;


@end
