//
//  YYHClockTextView.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/15.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHClockTextView.h"

@implementation YYHClockTextView

-(instancetype)initWithFrame:(CGRect)frame remainStr:(NSString *)remainStr
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 195)];
        _bgView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 265 -100);
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.tag = 10000;
        _bgView.layer.cornerRadius = 5;
        [self addSubview:_bgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.center = CGPointMake(_bgView.width / 2, 20);
        titleLabel.text = @"提示语";
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_bgView addSubview:titleLabel];
        
        _clockTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, _bgView.width - 20, 105)];
        _clockTextView.font = [UIFont systemFontOfSize:15];
        _clockTextView.layer.cornerRadius = 2;
        _clockTextView.layer.borderColor = [UIColor grayColor].CGColor;
        _clockTextView.text = remainStr;
        _clockTextView.delegate = self;
        [_bgView addSubview:_clockTextView];
        [_clockTextView becomeFirstResponder];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _bgView.height - 40, _bgView.width / 2, 40)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.backgroundColor = kColor(207, 207, 207);
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:cancelButton];
        
        UIBezierPath *cancelMaskPath = [UIBezierPath bezierPathWithRoundedRect:cancelButton.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *cancelMaskLayer = [[CAShapeLayer alloc] init];
        cancelMaskLayer.frame = cancelButton.bounds;
        cancelMaskLayer.path = cancelMaskPath.CGPath;
        cancelButton.layer.mask = cancelMaskLayer;
        
        UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(_bgView.width / 2 , _bgView.height - 40, _bgView.width / 2, 40)];
        [doneButton setTitle:@"确定" forState:UIControlStateNormal];
        [doneButton setBackgroundColor:kAppMainColor];
        doneButton.clipsToBounds = YES;
        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        doneButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:doneButton];
        
        UIBezierPath *doneMaskPath = [UIBezierPath bezierPathWithRoundedRect:doneButton.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *doneMaskLayer = [[CAShapeLayer alloc] init];
        doneMaskLayer.frame = doneButton.bounds;
        doneMaskLayer.path = doneMaskPath.CGPath;
        doneButton.layer.mask = doneMaskLayer;
    }
    return self;
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 40)
    {
        textView.text = [textView.text substringToIndex:40];
    }
}
-(void)cancelButtonClick
{
    [self fadeOut];
}
-(void)doneButtonClick
{
    if ([_addClockTextSuccessDelegate respondsToSelector:@selector(addClockTextSuccess:)])
    {
        [_addClockTextSuccessDelegate addClockTextSuccess:_clockTextView.text];
    }
    [self fadeOut];
}











@end
