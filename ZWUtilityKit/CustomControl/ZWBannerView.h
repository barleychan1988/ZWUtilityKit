//
//  ZWBannerView.h
//  ZWUtilityKit
//
//  Created by chenzw on 15/4/15.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//
/* ------------------------------------------------------
 *
 * @description：支持翻页滚动的banner
 *
 *
 * @update time: 2015-04-07
 *
 * ------------------------------------------------------*/
#import <UIKit/UIKit.h>


@protocol ZWBannerViewDelegate;
@protocol ZWBannerViewDatasource;

@interface ZWBannerView : UIView

@property (nonatomic, assign)id<ZWBannerViewDatasource> dataSource;
@property (nonatomic, assign)id<ZWBannerViewDelegate> delegate;
@property (nonatomic, assign, readonly)NSInteger nCurPageIndex;//获取当前显示页索引
@property (nonatomic, retain, readonly)UIScrollView *scrollView;//
@property (nonatomic, retain, readonly)UIPageControl *pageControl;//
@property (nonatomic, assign)BOOL bHiddenPageControl;//不显示PageControl
/*
 *  @brief：设置自动翻页
 *  @param：
 *      bAutoTurning：自动翻页标志
 *      ti：翻页间隔时间
 */
- (void)setAutoTurning:(BOOL)bAutoTurning timeInterval:(NSTimeInterval)ti;//自动翻页

- (void)reloadData;
- (void)showNextPageWithAnimate:(BOOL)bAnimate;
- (void)showPrePageWithAnimate:(BOOL)bAnimate;

@end



@protocol ZWBannerViewDelegate <NSObject>

@optional
//切换页面
- (void)bannerView:(ZWBannerView *)bannerView didPageChanged:(NSInteger)nCurIndex;
- (void)didClickPage:(ZWBannerView *)bannerView atIndex:(NSInteger)index;

@end



@protocol ZWBannerViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageViewAtIndex:(NSInteger)index;

@end
