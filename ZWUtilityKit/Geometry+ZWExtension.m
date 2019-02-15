//
//  Geometry.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/9/21.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "Geometry+ZWExtension.h"
#import <Math.h>


#pragma mark - CGPoint

double CGPointGetDistance(CGPoint point1, CGPoint point2)
{
    //Saving Variables.
    CGFloat fx = (point2.x - point1.x);
    CGFloat fy = (point2.y - point1.y);
    return sqrt(fx*fx + fy*fy);
}


#pragma mark - CGSize

CGSize CGSizeInsert(CGSize sz, CGFloat dx, CGFloat dy)
{
    sz.width += dx;
    sz.height += dy;
    return sz;
}

CGSize CGGetMaxInnerUniformScaleSize(CGSize sz, CGSize szOuter)
{
    CGSize szRet;
    szRet.width = szOuter.width;
    szRet.height = szRet.width * sz.height / sz.width;
    if (szOuter.height < szRet.height)
    {
        szRet.height = szOuter.height;
        szRet.width = szRet.height * sz.width / sz.height;
    }
    return szRet;
}

CGSize CGGetMinOuterUniformScaleSize(CGSize sz, CGSize szOuter)
{
    CGSize szRet;
    szRet.width = szOuter.width;
    szRet.height = szRet.width * sz.height / sz.width;
    if (szOuter.height > szRet.height)
    {
        szRet.height = szOuter.height;
        szRet.width = szRet.height * sz.width / sz.height;
    }
    return szRet;
}

#pragma mark - CGRect

CGPoint CGRectGetCenter(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect CGRectScale(CGRect rect, CGFloat wScale, CGFloat hScale)
{
    return CGRectMake(rect.origin.x * wScale, rect.origin.y * hScale, rect.size.width * wScale, rect.size.height * hScale);
}


#pragma mark -

CGFloat CGAffineTransformGetAngle(CGAffineTransform t)
{
    return atan2(t.b, t.a);
}

CGSize CGAffineTransformGetScale(CGAffineTransform t)
{
    return CGSizeMake(sqrt(t.a * t.a + t.c * t.c), sqrt(t.b * t.b + t.d * t.d)) ;
}
