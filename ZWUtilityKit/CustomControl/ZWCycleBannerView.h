//
//  CycleScrollView.h
//  ZWUtilityKit
//
//  Created by chenzw on 15/4/7.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

/* ------------------------------------------------------
 *
 * @description：可以循环滚动的ScrollView
 *
 *
 * @update time: 2015-04-07
 *
 * ------------------------------------------------------*/

#import <UIKit/UIKit.h>

@protocol ZWCycleBannerViewDelegate;
@protocol ZWCycleBannerViewDatasource;

@interface ZWCycleBannerView : UIView

@property (nonatomic, assign)id<ZWCycleBannerViewDatasource> dataSource;
@property (nonatomic, assign)id<ZWCycleBannerViewDelegate> delegate;
@property (nonatomic, assign, readonly)NSInteger nCurPageIndex;//获取当前显示页索引
@property (nonatomic, retain, readonly)UIScrollView *scrollView;//

- (UIPageControl *)getPageControl;
/*
 *  @brief：设置自动翻页
 *  @param：
 *      bAutoTurning：自动翻页标志
 *      ti：翻页间隔时间
 */
- (void)setAutoTurning:(BOOL)bAutoTurning timeInterval:(NSTimeInterval)ti;//自动翻页
//重新加载页面
- (void)reloadData;
- (void)showNextPageWithAnimate:(BOOL)bAnimate;
- (void)showPrePageWithAnimate:(BOOL)bAnimate;
@end



@protocol ZWCycleBannerViewDelegate <NSObject>

@optional
//切换页面
- (void)cycleBannerView:(ZWCycleBannerView *)csView didPageChanged:(NSInteger)nCurIndex;
- (void)didClickPage:(ZWCycleBannerView *)cycleBannerView atIndex:(NSInteger)index;

@end



@protocol ZWCycleBannerViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageViewAtIndex:(NSInteger)index;

@end
