//
//  Geometry.h
//  ZWUtilityKit
//
//  Created by chenzw on 15/9/21.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

#pragma mark - CGPoint

/*
 *  @brief：获取两点的距离
 */
double CGPointGetDistance(CGPoint point1, CGPoint point2);

#pragma mark - CGSize

inline CGSize CGSizeInsert(CGSize sz, CGFloat dx, CGFloat dy);

/**
 获取指定矩形区内，按照指定宽高比例的缩放的最大内接矩形大小

 @param sz 指定宽高比
 @param szOuter 指定矩形区
 @return 缩放后的最大内接区域大小
 */
inline CGSize CGGetMaxInnerUniformScaleSize(CGSize sz, CGSize szOuter);

/**
 获取指定矩形区内，按照指定宽高比例的缩放的最小外接矩形大小
 
 @param sz 指定宽高比
 @param szOuter 指定矩形区
 @return 缩放后的最小外接区域大小
 */
inline CGSize CGGetMinOuterUniformScaleSize(CGSize sz, CGSize szOuter);

#pragma mark - CGRect
/*
 *  @brief：获取CGRect的中心点
 */
inline CGPoint CGRectGetCenter(CGRect rect);
/*
 *  @brief：获取CGRect按指定比例拉伸后的CGRect
 *  @param：
 *      wSacle：横向拉伸比例
 *      hScale：纵向拉伸比例
 */
CGRect CGRectScale(CGRect rect, CGFloat wScale, CGFloat hScale);
/*
 *  @brief：
 */
inline CGFloat CGAffineTransformGetAngle(CGAffineTransform t);
/*
 *  @brief：
 */
inline CGSize CGAffineTransformGetScale(CGAffineTransform t);
