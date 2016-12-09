//
//  YYHLuoBoView.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHLuoBoView.h"
#import "JudgeTool.h"
@interface YYHLuoBoView ()

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,weak) UIPageControl *pageControl;
@property(nonatomic,weak) UICollectionViewFlowLayout *layout;
@property(nonatomic,weak) UICollectionView *collectionView;
@property(nonatomic,assign) NSInteger imagesCount;
@property(nonatomic,strong) NSMutableArray *IMGArray;

@end

static NSString *const ID = @"LunBoCollectionViewCell";

@implementation YYHLuoBoView

+(instancetype)bannerViewWithLocationImagesArr:(NSArray *)locationImgArr frame:(CGRect)frame
{
    YYHLuoBoView *lunbo = [[self alloc] initWithFrame:frame];
    if ([JudgeTool isEmptyArray:locationImgArr])
    {
        return lunbo;
    }
    lunbo.locationImageArr = [NSMutableArray arrayWithArray:locationImgArr];
    return lunbo;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initializeCollectionView];
    }
    return self;
}

-(void)initializeCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:self.frame.size];
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:0];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.layout = layout;
    
    UICollectionView *coll = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [coll setBackgroundColor:[UIColor clearColor]];
    [coll setPagingEnabled:YES];
    [coll registerClass:[YYHLunBoCollectionViewCell class] forCellWithReuseIdentifier:ID];
    [coll setDataSource:self];
    [coll setDelegate:self];
    [coll setShowsHorizontalScrollIndicator:NO];
    [coll setShowsVerticalScrollIndicator:NO];
    [self addSubview:coll];
    self.collectionView = coll;
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imagesCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row % _IMGArray.count;
    YYHLunBoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageView.image = _IMGArray[row];
    return cell;
    
}

-(void)setLocationImageArr:(NSMutableArray *)locationImageArr{
    _locationImageArr = locationImageArr;
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:locationImageArr.count];
    for (NSInteger i = 0; i < locationImageArr.count; i++)
    {
        UIImage *image = [UIImage imageNamed:locationImageArr[i]];
        [imageArr addObject:image];
    }
    self.IMGArray = imageArr;
}

-(void)setIMGArray:(NSMutableArray *)IMGArray
{
    _IMGArray = IMGArray;
    if (IMGArray.count > 1)
    {
        _imagesCount = IMGArray.count * 50;
    }
    else
    {
        _imagesCount = IMGArray.count;
    }
    
    if (IMGArray.count == 1)
    {
        [self removeTImers];
    }
    else
    {
        [self setupTimer];
    }
    
    [self setupPageControl];
    
    
}
-(void)setupPageControl
{
    if (_pageControl) return;
    UIPageControl *pageC = [[UIPageControl alloc] init];
    _pageControl = pageC;
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _IMGArray.count;
    [self addSubview:pageC];
}
-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    _pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_collectionView.contentOffset.x == 0 && _imagesCount)
    {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_imagesCount * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    _pageControl.frame = CGRectMake(0, self.height - 30, self.width, 30);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.width - 50) % 5;
    self.pageControl.currentPage = page;
}


-(void)setupTimer
{
    if (_locationImageArr.count == 1)
    {
        return;
    }
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    _timer = time;
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
-(void)removeTImers
{
    [_timer invalidate];
    _timer = nil;
}

-(void)timerRun
{
    
    if (!_imagesCount)
    {
        return;
    }
    int index = (_collectionView.contentOffset.x / _layout.itemSize.width) + 1;
    if (index == _imagesCount)
    {
        index = _imagesCount * 0.5;
       
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}
-(void)setTimeInterval:(CGFloat)timeInterval
{
    _timeInterval = timeInterval;
    if ((timeInterval <= 0))
    {
        _timeInterval = 1.5;
    }
    [self removeTImers];
    [self setupTimer];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTImers];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    
    if (!newSuperview)
    {
        [self removeTImers];
    }
}

@end
