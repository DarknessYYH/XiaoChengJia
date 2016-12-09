//
//  YYHBaseModel.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YYHBaseModel : NSObject

@property (nonatomic,copy) NSString *objectId;
@property (nonatomic,copy) NSString *createdAt;
@property (nonatomic,copy) NSString *updatedAt;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
