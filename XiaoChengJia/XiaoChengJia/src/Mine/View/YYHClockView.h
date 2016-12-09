//
//  YYHClockView.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/8.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface YYHClockView : UIView
{
	CALayer *_containerLayer;
	CALayer *_hourHand;
	CALayer *_minHand;
	CALayer *_secHand;
	NSTimer *_timer;
}

//basic methods
- (void)start;
- (void)stop;

//customize appearence
- (void)setHourHandImage:(CGImageRef)image;
- (void)setMinHandImage:(CGImageRef)image;
- (void)setSecHandImage:(CGImageRef)image;
- (void)setClockBackgroundImage:(CGImageRef)image;

@end
