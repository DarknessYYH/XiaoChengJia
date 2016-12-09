//
//  YYHAnimationView.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYHAnimationDelegate <NSObject>

@optional
-(void)viewWillPushDown;
-(void)viewWillDissmiss;

@end

@interface YYHAnimationView : UIView
@property(nonatomic,assign) BOOL isShow;
@property(nonatomic,weak) id<YYHAnimationDelegate> delegate;

-(void)pushUp:(UIView *)view;
-(void)pushDown:(UIView *)view;
-(void)fadeIn:(UIView *)view;
-(void)fadeOut;
-(void)showIn:(UIView *)view;
-(void)dismiss;







@end
