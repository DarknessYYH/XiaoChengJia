//
//  YYHNKColorSwitch.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/12.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHNKColorSwitch.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat kAnimateDuration = 0.3f;
static const CGFloat kHorizontaleAdjustment = 5.0f;
static const CGFloat kRectShapeCornerRadius = 4.0f;
static const CGFloat kThumbShadowOpacity = 0.3f;
static const CGFloat kThumbShadowRadius = 0.5f;
static const CGFloat kSwitchBorderWidth = 1.75f;

@interface YYHNKColorSwitch ()
@property(nonatomic,strong) UIView *onBackgroundView;
@property(nonatomic,strong) UIView *offBackgroundView;
@property(nonatomic,strong) UIView *thumbView;
@end

@implementation YYHNKColorSwitch
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUI];
    }
    return self;
}
-(void)setupUI
{
    self.shape = kNKColorSwitchShapeOval;
    [self setBackgroundColor:[UIColor clearColor]];
    self.onBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.onBackgroundView setBackgroundColor:kColor(53, 184, 174)];
    [self.onBackgroundView.layer setCornerRadius:self.height / 2];
    [self.onBackgroundView.layer setShouldRasterize:YES];
    [self.onBackgroundView.layer setRasterizationScale:[UIScreen mainScreen].scale];
    [self addSubview:self.onBackgroundView];
    
    UILabel *noLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 20, 20)];
    noLabel.text = @"开";
    noLabel.textColor = [UIColor whiteColor];
    noLabel.font = [UIFont systemFontOfSize:15];
    [self.onBackgroundView addSubview:noLabel];
    
    self.offBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.offBackgroundView setBackgroundColor:[UIColor whiteColor]];
    [self.offBackgroundView.layer setCornerRadius:self.height / 2];
    [self.offBackgroundView.layer setShouldRasterize:YES];
    [self.offBackgroundView.layer setRasterizationScale:[UIScreen mainScreen].scale];
    [self addSubview:self.offBackgroundView];
    
    UILabel *offLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.offBackgroundView.width - 35, 5, 20, 20)];
    offLabel.text = @"关";
    offLabel.font = [UIFont systemFontOfSize:15];
    offLabel.textColor = [UIColor whiteColor];
    [self.offBackgroundView addSubview:offLabel];
    
    self.thumbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.height - kHorizontaleAdjustment, self.height - kHorizontaleAdjustment)];
    [self.thumbView setBackgroundColor:[UIColor whiteColor]];
    [self.thumbView setUserInteractionEnabled:YES];
    [self.thumbView.layer setCornerRadius:(self.height - kHorizontaleAdjustment) / 2];
    [self.thumbView.layer setShadowOffset:CGSizeMake(0, 1)];
    [self.thumbView.layer setShouldRasterize:YES];
    [self.thumbView.layer setShadowOpacity:kThumbShadowOpacity];
    [self.thumbView.layer setRasterizationScale:[UIScreen mainScreen].scale];
    [self addSubview:self.thumbView];
    self.shadow = YES;
    
    [self.thumbView setCenter:CGPointMake(self.thumbView.width / 2, self.height / 2)];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwitchTap:)];
    [tapGestureRecognizer setDelegate:self];
    [self.thumbView addGestureRecognizer:tapGestureRecognizer];
    
    UITapGestureRecognizer *tapBgGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBgTap:)];
    [tapBgGestureRecognizer setDelegate:self];
    [self addGestureRecognizer:tapBgGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panGestureRecognizer setDelegate:self];
    [self.thumbView addGestureRecognizer:panGestureRecognizer];
    [self setOn:NO];
    
    
}

-(void)setOn:(BOOL)on
{
    if (_on != on)
    {
        _on = on;
    }
    if (_on)
    {
        [self.onBackgroundView setAlpha:1.0];
        self.offBackgroundView.transform = CGAffineTransformMakeScale(0.0, 0.0);
        self.thumbView.center = CGPointMake(self.onBackgroundView.width - (self.thumbView.width +kHorizontaleAdjustment) / 2, self.thumbView.center.y);
        
        
    }
    else
    {
        [self.onBackgroundView setAlpha:0.0];
        self.offBackgroundView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.thumbView.center =CGPointMake((self.thumbView.width + kHorizontaleAdjustment) / 2, self.thumbView.center.y);
        
    }
    
    
}

-(void)setOnTintColor:(UIColor *)onTintColor
{
    if (_onTintColor != onTintColor)
    {
        _onTintColor = onTintColor;
    }
    [self.onBackgroundView setBackgroundColor:onTintColor];
}
-(void)setOnTintBorderColor:(UIColor *)onTintBorderColor
{
    if (_onTintBorderColor != onTintBorderColor)
    {
        _onTintBorderColor = onTintBorderColor;
    }
    [self.onBackgroundView.layer setBorderColor:onTintBorderColor.CGColor];
    if (onTintBorderColor)
    {
        [self.onBackgroundView.layer setBorderWidth:kSwitchBorderWidth];
        
    }
    else
    {
        [self.onBackgroundView.layer setBorderWidth:0.0];
    }
}
-(void)setTintColor:(UIColor *)tintColor
{
    if (_tintColor != tintColor)
    {
        _tintColor = tintColor;
    }
    [self.offBackgroundView setBackgroundColor:tintColor];
}
-(void)setTintBorderColor:(UIColor *)tintBorderColor
{
    if (_tintBorderColor != tintBorderColor)
    {
        _tintBorderColor = tintBorderColor;
    }
    [self.offBackgroundView.layer setBorderColor:tintBorderColor.CGColor];
    if (tintBorderColor)
    {
        [self.offBackgroundView.layer setBorderWidth:kSwitchBorderWidth];
    }
    else
    {
        [self.offBackgroundView.layer setBorderWidth:0.0];
    }
}
-(void)setThumbTintColor:(UIColor *)thumbTintColor
{
    if (_thumbTintColor != thumbTintColor)
    {
        _thumbTintColor = thumbTintColor;
    }
    [self.thumbView setBackgroundColor:thumbTintColor];
}
-(void)setShape:(NKColorSwitchShape)shape
{
    if (_shape != shape)
    {
        _shape = shape;
    }
    if (shape == kNKColorSwitchShapeOval)
    {
        [self.onBackgroundView.layer setCornerRadius:self.height / 2];
        [self.offBackgroundView.layer setCornerRadius:self.height / 2];
        [self.thumbView.layer setCornerRadius:(self.height - kHorizontaleAdjustment) / 2];
    }
    else if (shape == kNKColorSwitchShapeRectangle)
    {
        [self.onBackgroundView.layer setCornerRadius:kRectShapeCornerRadius];
        [self.offBackgroundView.layer setCornerRadius:kRectShapeCornerRadius];
        [self.thumbView.layer setCornerRadius:kRectShapeCornerRadius];
    }
    else if (shape == kNKColorSwitchShapeRectangleNoCorner )
    {
        [self.onBackgroundView.layer setCornerRadius:0.0];
        [self.offBackgroundView.layer setCornerRadius:0.0];
        [self.thumbView.layer setCornerRadius:0.0];
    }
}

-(void)setShadow:(BOOL)shadow
{
    if (_shadow != shadow)
    {
        _shadow = shadow;
    }
    if (shadow)
    {
        [self.thumbView.layer setShadowOffset:CGSizeMake(0, 1)];
        [self.thumbView.layer setShadowRadius:kThumbShadowRadius];
        [self.thumbView.layer setShadowOpacity:kThumbShadowOpacity];
    }
    else
    {
        [self.thumbView.layer setShadowOpacity:0.0];
        [self.thumbView.layer setShadowRadius:0.0];
    }
}
-(void)animateToDestination:(CGPoint)centerPoint withDuration:(CGFloat)duration switch:(BOOL)on
{
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        self.thumbView.center = centerPoint;
        if (on)
        {
            [self.onBackgroundView setAlpha:1.0];
            
        }
        else
        {
            [self.onBackgroundView setAlpha:0.0];
        }
    }
                     completion:^(BOOL finished)
     {
        if (finished) {
            [self updateSwitch:on];
        }
    }];
    [UIView animateWithDuration:duration
                          delay:0.075f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         if (on)
                         {
                             self.offBackgroundView.transform = CGAffineTransformMakeScale(0.0, 0.0);
                         }
                         else
                         {
                             self.offBackgroundView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         }
    }
                     completion:^(BOOL finished)
    {
                         
                     }];
}


-(void)updateSwitch:(BOOL)on
{
    if (_on != on)
    {
        _on = on;
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.thumbView];
    CGPoint newCenter = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y);
    if (newCenter.x < (recognizer.view.width + kHorizontaleAdjustment) / 2 || newCenter.x > self.onBackgroundView.frame.size.width - (recognizer.view.width + kHorizontaleAdjustment) / 2)
    {
        if (recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged)
        {
            CGPoint velocity = [recognizer velocityInView:self.thumbView];
            if (velocity.x >= 0)
            {
                [self animateToDestination:CGPointMake(self.onBackgroundView.width - (self.thumbView.width + kHorizontaleAdjustment) / 2, recognizer.view.center.y) withDuration:kAnimateDuration switch:YES];
            }
            else
            {
                [self animateToDestination:CGPointMake((self.thumbView.width + kHorizontaleAdjustment) / 2, recognizer.view.center.y) withDuration:kAnimateDuration switch:NO];
            }
        }
        return;
    }
    
    
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.thumbView];
    CGPoint velocity = [recognizer velocityInView:self.thumbView];
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (velocity.x >= 0)
        {
            if (recognizer.view.center.x < self.onBackgroundView.width - (self.thumbView.width +kHorizontaleAdjustment) / 2)
            {
                [self animateToDestination:CGPointMake(self.onBackgroundView.width - (self.thumbView.width + kHorizontaleAdjustment) / 2, recognizer.view.center.y) withDuration:kAnimateDuration switch:YES];
            }
        }
        else
        {
            [self animateToDestination:CGPointMake((self.thumbView.width + kHorizontaleAdjustment) / 2, recognizer.view.center.y) withDuration:kAnimateDuration switch:NO];
        }
    }
    
}
-(void)handleSwitchTap:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (self.isOn)
        {
            [self animateToDestination:CGPointMake((self.thumbView.width + kHorizontaleAdjustment) / 2, recognizer.view.center.y) withDuration:kAnimateDuration switch:NO];
        }
        else
        {
            [self animateToDestination:CGPointMake(self.onBackgroundView.width - (self.thumbView.width + kHorizontaleAdjustment) / 2, recognizer.view.center.y) withDuration:kAnimateDuration switch:YES];
        }
    }
}
-(void)handleBgTap:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (self.isOn)
        {
            [self animateToDestination:CGPointMake((self.thumbView.width + kHorizontaleAdjustment) / 2, self.thumbView.center.y) withDuration:kAnimateDuration switch:NO];
        }
        else
        {
            [self animateToDestination:CGPointMake(self.onBackgroundView.width - (self.thumbView.width + kHorizontaleAdjustment) / 2, self.thumbView.center.y) withDuration:kAnimateDuration switch:YES];
        }
    }
}


@end
