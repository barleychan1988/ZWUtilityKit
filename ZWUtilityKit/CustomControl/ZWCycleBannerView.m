//
//  CycleScrollView.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/4/7.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "ZWCycleBannerView.h"

@interface ZWCycleBannerView()<UIScrollViewDelegate>
{
    UIScrollView *m_scrollView;
    UIPageControl *m_pageControl;
    NSTimer *m_timer;//自动翻页的定时器
    
    NSMutableArray *m_mtArrayCurViews;
}

@end

@implementation ZWCycleBannerView

- (void)setDataSource:(id<ZWCycleBannerViewDatasource>)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        scrollView.scrollsToTop = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        scrollView.pagingEnabled = YES;
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:scrollView];
        m_scrollView = scrollView;
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:rect];
        pageControl.userInteractionEnabled = NO;
        pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:pageControl];
        m_pageControl = pageControl;
    }
    return self;
}

- (void)reloadData
{
    NSInteger nPageNum = [_dataSource numberOfPages];
    if (nPageNum == 0)
    {
        m_pageControl.hidden = YES;
        m_scrollView.scrollEnabled = NO;
        return;
    }
    else if (nPageNum == 1)
    {
        m_pageControl.hidden = YES;
        m_scrollView.scrollEnabled = NO;
    }
    else
    {
        m_pageControl.hidden = NO;
        m_scrollView.scrollEnabled = YES;
    }
    m_pageControl.numberOfPages = nPageNum;
    _nCurPageIndex = 0;
    [self loadData];
    if ([_delegate respondsToSelector:@selector(cycleBannerView:didPageChanged:)])
    {
        [_delegate cycleBannerView:self didPageChanged:_nCurPageIndex];
    }
}

- (void)loadData
{
    if (m_pageControl.numberOfPages == 0)
    {
        return;
    }
    m_pageControl.currentPage = _nCurPageIndex;
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [m_scrollView subviews];
    if([subViews count] != 0)
    {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_nCurPageIndex];
    CGRect frame;
    for (int i = 0; i < 3; i++)
    {
        UIView *v = [m_mtArrayCurViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [v addGestureRecognizer:singleTap];
        frame = v.frame;
        if (frame.size.width == 0)
        {
            frame.size.width = m_scrollView.frame.size.width;
        }
        if (frame.size.height == 0)
        {
            frame.size.height = m_scrollView.frame.size.height;
        }
        v.frame = CGRectOffset(frame, frame.size.width * i, 0);
        [m_scrollView addSubview:v];
    }
    [m_scrollView setContentOffset:CGPointMake(m_scrollView.frame.size.width, 0)];
}

- (void)getDisplayImagesWithCurpage:(NSInteger)page
{
    NSInteger nPre = [self validPageValue:_nCurPageIndex - 1];
    NSInteger nLast = [self validPageValue:_nCurPageIndex + 1];
    
    if (!m_mtArrayCurViews)
    {
        m_mtArrayCurViews = [[NSMutableArray alloc] init];
    }
    
    [m_mtArrayCurViews removeAllObjects];
    
    [m_mtArrayCurViews addObject:[_dataSource pageViewAtIndex:nPre]];
    [m_mtArrayCurViews addObject:[_dataSource pageViewAtIndex:page]];
    [m_mtArrayCurViews addObject:[_dataSource pageViewAtIndex:nLast]];
}

- (NSInteger)validPageValue:(NSInteger)value
{
    if(value == -1)
        value = [_dataSource numberOfPages] - 1;
    if(value == [_dataSource numberOfPages])
        value = 0;
    return value;
}

//点击当前视图
- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)])
    {
        [_delegate didClickPage:self atIndex:_nCurPageIndex];
    }    
}

//定时器自动翻页调用
- (void)autoTurnPage:(id)sender
{
    [self showNextPageWithAnimate:YES];
}

#pragma mark -

- (void)setAutoTurning:(BOOL)bAutoTurning timeInterval:(NSTimeInterval)ti
{
    if (bAutoTurning)
    {
        [m_timer invalidate];
        m_timer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(autoTurnPage:) userInfo:nil repeats:YES];
    }
    else
    {
        [m_timer invalidate];
        m_timer = nil;
        NSInteger nPageCur = m_scrollView.contentOffset.x / m_scrollView.frame.size.width;
        m_scrollView.contentOffset = CGPointMake(m_scrollView.frame.size.width * nPageCur, m_scrollView.contentOffset.y);
    }
}

- (UIPageControl *)getPageControl
{
    return m_pageControl;
}

- (void)showPrePageWithAnimate:(BOOL)bAnimate
{
    [m_scrollView setContentOffset:CGPointMake(0, 0) animated:bAnimate];
}

- (void)showNextPageWithAnimate:(BOOL)bAnimate
{
    [m_scrollView setContentOffset:CGPointMake(m_scrollView.frame.size.width * 2, 0) animated:bAnimate];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    int x = aScrollView.contentOffset.x;
    
    //往下翻一张
    if(x >= (2*self.frame.size.width))
    {
        _nCurPageIndex = [self validPageValue:_nCurPageIndex + 1];
        [self loadData];
        if ([_delegate respondsToSelector:@selector(cycleBannerView:didPageChanged:)])
        {
            [_delegate cycleBannerView:self didPageChanged:_nCurPageIndex];
        }
    }
    //往上翻
    if(x <= 0)
    {
        _nCurPageIndex = [self validPageValue:_nCurPageIndex - 1];
        [self loadData];
        if ([_delegate respondsToSelector:@selector(cycleBannerView:didPageChanged:)])
        {
            [_delegate cycleBannerView:self didPageChanged:_nCurPageIndex];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
    [m_scrollView setContentOffset:CGPointMake(m_scrollView.frame.size.width, 0) animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([m_timer isValid])
    {
        [m_timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([m_timer isValid])
    {
        [m_timer setFireDate:[[NSDate date] dateByAddingTimeInterval:m_timer.timeInterval]];
    }
}
@end