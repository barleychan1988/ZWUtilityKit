//
//  ZWBannerView.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/4/15.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "ZWBannerView.h"
#import "UtilityUIKit.h"

@interface ZWBannerView()<UIScrollViewDelegate>
{
    NSTimer *m_timer;//自动翻页的定时器
    
    NSArray<UIView *> *m_arrayPageView;
}
@end

@implementation ZWBannerView

#pragma mark - property

- (void)setDataSource:(id<ZWBannerViewDatasource>)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}

- (void)setBHiddenPageControl:(BOOL)bHiddenPageControl
{
    _bHiddenPageControl = bHiddenPageControl;
    _pageControl.hidden = bHiddenPageControl;
}

#pragma mark - init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        scrollView.pagingEnabled = YES;
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:scrollView];
        _scrollView = scrollView;
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:rect];
        pageControl.userInteractionEnabled = NO;
        pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return self;
}

- (void)removeFromSuperview
{
    [m_timer invalidate];
    m_timer = nil;
    [super removeFromSuperview];
}

- (void)layoutSubviews
{
    [super layoutSubviews];    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _pageControl.numberOfPages, 0);
    CGRect frame;
    int n = 0;
    for (UIView *subview in m_arrayPageView)
    {
        frame.size = _scrollView.frame.size;
        frame.origin = CGPointZero;
        subview.frame = CGRectOffset(frame, _scrollView.frame.size.width * n++, 0);
    }
}

#pragma mark

- (void)loadData
{
    if (_pageControl.numberOfPages == 0)
    {
        return;
    }
    _pageControl.currentPage = _nCurPageIndex;
    NSMutableArray *mtArray = [NSMutableArray arrayWithCapacity:_pageControl.numberOfPages];
    CGRect frame;
    for (int n = 0; n < _pageControl.numberOfPages; n++)
    {
        UIView *view = [_dataSource pageViewAtIndex:n];
        view.userInteractionEnabled = YES;
        /*/没有必要 czw 160624
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [view addGestureRecognizer:singleTap];*/
        if ([view isKindOfClass:[UIImageView class]])
        {
            UIImageView *imageView = (UIImageView *)view;
            if (imageView.image != nil)
            {
                view = [[UIView alloc] initWithFrame:imageView.frame];
                [view addSubview:imageView];
                
                CGFloat fScaleWidth =  view.bounds.size.width / imageView.image.size.width;
                CGFloat fScale = view.bounds.size.height / imageView.image.size.height;
                if (fScale > fScaleWidth)
                    fScale = fScaleWidth;
                frame.size.width = fScale * imageView.image.size.width;
                frame.size.height = fScale * imageView.image.size.height;
                frame.origin.x = (view.bounds.size.width - frame.size.width) / 2;
                frame.origin.y = (view.bounds.size.height - frame.size.height) / 2;
                imageView.frame = frame;
            }
        }
        [_scrollView addSubview:view];
        [mtArray addObject:view];
    }
    m_arrayPageView = mtArray;
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * _nCurPageIndex, 0);
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
    if (_pageControl.currentPage == [_dataSource numberOfPages] - 1)
    {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else
    {
        CGPoint offset = _scrollView.contentOffset;
        [_scrollView setContentOffset:CGPointMake(offset.x + _scrollView.frame.size.width, 0) animated:YES];
    }
}

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
    }
}

- (void)reloadData
{
    removeAllSubviews(_scrollView);
    
    NSInteger nPageNum = [_dataSource numberOfPages];
    if (nPageNum == 0)
    {
        _scrollView.scrollEnabled = NO;
        return;
    }
    else if (nPageNum == 1)
    {
        _scrollView.scrollEnabled = YES;
    }
    else
    {
        _scrollView.scrollEnabled = YES;
    }
    _pageControl.hidden = _bHiddenPageControl;
    _pageControl.numberOfPages = nPageNum;
    _nCurPageIndex = 0;
    [self loadData];
    if ([_delegate respondsToSelector:@selector(bannerView:didPageChanged:)])
    {
        [_delegate bannerView:self didPageChanged:_nCurPageIndex];
    }
}

- (void)showPrePageWithAnimate:(BOOL)bAnimate
{
    CGPoint offset = _scrollView.contentOffset;
    offset.x -= _scrollView.frame.size.width;
    if (offset.x >= 0)
    {
        [_scrollView setContentOffset:CGPointMake(offset.x, 0) animated:YES];
    }
}

- (void)showNextPageWithAnimate:(BOOL)bAnimate
{
    CGPoint offset = _scrollView.contentOffset;
    offset.x += _scrollView.frame.size.width;
    if (offset.x < _scrollView.contentSize.width)
    {
        [_scrollView setContentOffset:CGPointMake(offset.x, 0) animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int x = scrollView.contentOffset.x;
    CGFloat fPageWidth = scrollView.frame.size.width;
    NSInteger nNewCurentPage = (x + fPageWidth / 2) / fPageWidth;
    if (nNewCurentPage != _pageControl.currentPage)
    {
        _nCurPageIndex = nNewCurentPage;
        _pageControl.currentPage = nNewCurentPage;
        if ([_delegate respondsToSelector:@selector(bannerView:didPageChanged:)])
        {
            [_delegate bannerView:self didPageChanged:_pageControl.currentPage];
        }
    }
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