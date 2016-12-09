//
//  YYHNKColorSwitch.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/12.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    kNKColorSwitchShapeOval,
    kNKColorSwitchShapeRectangle,
    kNKColorSwitchShapeRectangleNoCorner
} NKColorSwitchShape;


@interface YYHNKColorSwitch : UIControl<UIGestureRecognizerDelegate>
@property(nonatomic,getter = isOn) BOOL on;
@property(nonatomic,assign) NKColorSwitchShape shape;
@property(nonatomic,strong) UIColor *onTintColor;
@property(nonatomic,strong) UIColor *tintColor;
@property(nonatomic,strong) UIColor *thumbTintColor;
@property(nonatomic,assign) BOOL shadow;
@property(nonatomic,strong) UIColor *tintBorderColor;
@property(nonatomic,strong) UIColor *onTintBorderColor;




@end
