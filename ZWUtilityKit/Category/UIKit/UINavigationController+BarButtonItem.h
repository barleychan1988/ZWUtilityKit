//
//  UINavigationController+BarButtonItem.h
//  ZWUtilityKit
//
//  Created by 陈正旺 on 15/1/30.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

/*
 *  @description:提供设置导航栏中按钮
 *      导航栏在iOS7以后的系统中，默认设置最左边留有15个基本像素的空余
 */

#import <UIKit/UIKit.h>
#import "UtilityKit.h"

#define TOP_STATUS_BAR_HEIGHT (IOS7 ? Status_Bar_Height : 0)
#define Nav_Left_BarItem_Offset (IOS7 ? -16.0f : 0.0f)
#define Nav_Right_BarItem_Offset (IOS7 ? -16.0f : -5.0f)
#define Navigation_Bar_Animaiton_Interval 0.5

@interface UINavigationController (BarButtonItem)<UIGestureRecognizerDelegate>

- (void)setDefaultBackBarButtonItem;
- (UIBarButtonItem *)defaultLeftBackItem;

- (void)setLeftBarButtonItem:(UIBarButtonItem *)item offset:(float)offset;
- (void)setRightBarButtonItem:(UIBarButtonItem *)item offset:(float)offset;

- (void)setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)arrayItems offset:(float)offset;

- (UIBarButtonItem*)createNavButton:(NSString *)strImageName highImage:(NSString *)strHighImage title:(NSString *)strTitle target:(id)target action:(SEL)btnAction;

/*
 *  @brief：设置导航栏左边的BarButtonItem
 *
 */
- (void)setLeftButtonItem:(UIButton *)btn;
/*
 *  @brief：设置导航栏右边的BarButtonItem
 *
 */
- (void)setRightButtonItem:(UIButton *)btn;

@end