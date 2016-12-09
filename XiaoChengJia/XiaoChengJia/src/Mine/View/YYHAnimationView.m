//
//  YYHAnimationView.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHAnimationView.h"

@implementation YYHAnimationView

-(void)fadeIn:(UIView *)view
{
    [view addSubview:self];
    self.isShow = YES;
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
-(void)fadeOut
{
    [UIView animateWithDuration:0.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    } completion:^(BOOL finished) {
        if (finished) {
            self.isShow = NO;
            [self removeFromSuperview];
        }
    }];
}
-(void)pushUp:(UIView *)view
{
    [view addSubview:self];
    self.isShow = YES;
    self.backgroundColor = [ UIColor colorWithWhite:0.0 alpha:0.0];
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        view.frame = CGRectMake(0, 0, view.width, view.height);
    }];
}
-(void)pushDown:(UIView *)view
{
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        view.frame = CGRectMake(0, SCREEN_HEIGHT, view.width , view.height);
    } completion:^(BOOL finished) {
        if (finished) {
            self.isShow = NO;
            if ([_delegate respondsToSelector:@selector(viewWillPushDown)]) {
                [_delegate viewWillPushDown];
            }
            [self removeFromSuperview];
        }
    }];
}
-(void)showIn:(UIView *)view
{
    [view addSubview:self];
    self.isShow = YES;
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}
-(void)dismiss
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.isShow = NO;
            if ([_delegate respondsToSelector:@selector(viewWillDissmiss)]) {
                [_delegate viewWillDissmiss];
            }
            [self removeFromSuperview];
        }
    }];
}












@end
