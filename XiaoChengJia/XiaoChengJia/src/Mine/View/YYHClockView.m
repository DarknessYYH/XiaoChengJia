//
//  YYHClockView.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/8.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHClockView.h"


@implementation YYHClockView

#pragma mark - Public Methods

- (void)start
{
	_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClock:) userInfo:nil repeats:YES];
}

- (void)stop
{
	[_timer invalidate];
	_timer = nil;
}

//customize appearence
- (void)setHourHandImage:(CGImageRef)image
{
	_hourHand.contents = (id)image;
}

- (void)setMinHandImage:(CGImageRef)image
{
	_minHand.contents = (id)image;
}

- (void)setSecHandImage:(CGImageRef)image
{
	_secHand.contents = (id)image;
}

- (void)setClockBackgroundImage:(CGImageRef)image
{
	_containerLayer.contents = (id)image;
}

#pragma mark - Private Methods

//Default sizes of hands:
//in percentage (0.0 - 1.0)
#define HOURS_HAND_LENGTH 0.4
#define MIN_HAND_LENGTH 0.46
#define SEC_HAND_LENGTH 0.5
//in pixels
#define HOURS_HAND_WIDTH 2
#define MIN_HAND_WIDTH 2
#define SEC_HAND_WIDTH 3

float Degrees2Radians(float degrees) { return degrees * M_PI / 180; }

//timer callback
- (void) updateClock:(NSTimer *)theTimer
{
	
	NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
	NSInteger seconds = [dateComponents second];
	NSInteger minutes = [dateComponents minute];
	NSInteger hours = [dateComponents hour];
	//DLog(@"raw: hours:%d min:%d secs:%d", hours, minutes, seconds);
	if (hours > 12) hours -= 12; //PM

	//set angles for each of the hands
	CGFloat secAngle = Degrees2Radians(seconds / 60.0 * 360);
	CGFloat minAngle = Degrees2Radians(minutes / 60.0 * 360);
	CGFloat hourAngle = Degrees2Radians(hours / 12.0 * 360) + minAngle / 12.0;
	
	//reflect the rotations + 180 degres since CALayers coordinate system is inverted
	_secHand.transform = CATransform3DMakeRotation (secAngle+M_PI, 0, 0, 1);
	_minHand.transform = CATransform3DMakeRotation (minAngle+M_PI, 0, 0, 1);
	_hourHand.transform = CATransform3DMakeRotation (hourAngle+M_PI, 0, 0, 1);
    
}

#pragma mark - Overrides

- (void) layoutSubviews
{
	[super layoutSubviews];

	_containerLayer.frame = CGRectMake(0, 0, self.width, self.height);

	float length = MIN(self.width, self.height) / 2;
	CGPoint c = CGPointMake(self.width / 2, self.height / 2);
	_hourHand.position = _minHand.position = _secHand.position = c;
    
	CGFloat w, h;
	
	if (_hourHand.contents == NULL)
    {
		w = HOURS_HAND_WIDTH;
		h = length*HOURS_HAND_LENGTH;
	}
    else
    {
        w = 4;
        h = 45;
	}
	_hourHand.bounds = CGRectMake(0,0,w-10,h);
	
	if (_minHand.contents == NULL)
    {
		w = MIN_HAND_WIDTH;
		h = length * MIN_HAND_LENGTH;
	}
    else
    {
        w = 4;
        h = 61;
	}
	_minHand.bounds = CGRectMake(0,0,w,h);
	
	if (_secHand.contents == NULL)
    {
		w = SEC_HAND_WIDTH;
		h = length * SEC_HAND_LENGTH;
	}
    else
    {
        w = 2;
        h = 68;
	}
	_secHand.bounds = CGRectMake(0,0,w,h);

	_hourHand.anchorPoint = CGPointMake(0.5,0.0);
	_minHand.anchorPoint = CGPointMake(0.5,0.0);
	_secHand.anchorPoint = CGPointMake(0.5,0.0);
	_containerLayer.anchorPoint = CGPointMake(0.5, 0.5);
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
    {
		
		_containerLayer = [[CALayer layer] retain];
		_hourHand = [[CALayer layer] retain];
		_minHand = [[CALayer layer] retain];
		_secHand = [[CALayer layer] retain];

		//default appearance
		[self setClockBackgroundImage:NULL];
		[self setHourHandImage:NULL];
		[self setMinHandImage:NULL];
		[self setSecHandImage:NULL];
		
		//add all created sublayers
		[_containerLayer addSublayer:_hourHand];
		[_containerLayer addSublayer:_minHand];
		[_containerLayer addSublayer:_secHand];
		[self.layer addSublayer:_containerLayer];
	}
	return self;
}

- (void)dealloc
{
	[self stop];
	[_hourHand release];
	[_minHand release];
	[_secHand release];
	[_containerLayer release];

	[super dealloc];
}

@end