//
//  UINavigationController+Orientation.h
//  ODB
//
//  Created by chenzhengwang on 14-3-15.
//  Copyright (c) 2014年 lixufeng. All rights reserved.
//
/*
 *  @description:解决在ios7中设备旋转问题
 *
 *
 */

#import <UIKit/UIKit.h>

@interface UINavigationController_Orientation : UINavigationController

/*
 * @brief: 设置导航栏的背景图片
 * @prama: image:背景图片
 *
 */
- (void)setBackgroundImage:(UIImage *)image;

@end