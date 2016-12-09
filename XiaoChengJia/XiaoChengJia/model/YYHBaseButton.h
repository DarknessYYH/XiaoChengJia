//
//  YYHBaseButton.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/3.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BaseButtonType)
{
    BaseButtonTypeCenter,
    BaseButtonTypeDefault,
};

@interface YYHBaseButton : UIButton

@property(nonatomic,assign)BaseButtonType baseButtonType;
- (instancetype)initWithType:(BaseButtonType)type;

@end
