//
//  YYHClockTextView.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/15.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHAnimationView.h"

@protocol YYHAddClockTextSuccessDelegate <NSObject>

-(void)addClockTextSuccess:(NSString *)str;

@end


@interface YYHClockTextView : YYHAnimationView<UITextViewDelegate>
{
    UIView *_bgView;
    UITextView *_clockTextView;
}
@property(nonatomic,assign) id<YYHAddClockTextSuccessDelegate> addClockTextSuccessDelegate;
-(instancetype)initWithFrame:(CGRect)frame remainStr:(NSString *)remainStr;





@end
