//
//  UIViewController+NavigationBackround.h
//  Pods
//
//  Created by Eadkenny on 2018/1/16.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationBackround)

- (void)setNavBarBackgroundColor:(nullable UIColor *)color;
/*
 *  @brief: 设置导航栏背景图
 *      如果需要状态栏背景跟随导航栏变化，则背景图高度需包含状态栏高度
 */
- (void)setNavBarBackgroundImage:(nullable UIImage *)image;

@end
