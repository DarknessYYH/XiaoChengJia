//
//  DATManager.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/20.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailModelDAT.h"
#import "CollectionModelDAT.h"

@interface DATManager : NSObject

@property (nonatomic, strong) DetailModelDAT *detailModelDAT;
@property (nonatomic, strong) CollectionModelDAT *collectionModelDAT;

+ (instancetype)sharedDATManager;

@end
