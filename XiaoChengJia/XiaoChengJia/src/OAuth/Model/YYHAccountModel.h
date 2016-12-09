//
//  YYHAccountModel.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/28.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBaseModel.h"
//要为自定义的数据类型添加归档，需要添加NSCoding协议并重写对应的方法
@interface YYHAccountModel : NSObject <NSCoding>
//access_token
@property(nonatomic,copy)NSString *access_token;
@property(nonatomic,copy)NSString *expires_in;
@property(nonatomic,copy)NSString *remind_id;
@property(nonatomic,copy)NSString *uid;
//userInfo
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *profile_image_url;//使用小头像图片
@property(nonatomic,copy)NSString *idescription;
@property(nonatomic,copy)NSString *gender;
@property(nonatomic,copy)NSString *location;

- (void)initWithRespondObject:(id)object;

@end

