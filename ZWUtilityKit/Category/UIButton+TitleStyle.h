//
//  UIButton.h
//  ZWUtilityKit
//
//  Created by chenzw on 15/4/17.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//
/*
 *  @description:UIButton一般同时设置image和title时，title将显示在image的右边
 */
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIButtonTitleStyle)
{
    UIButtonTitleStyleRight = 0,
    UIButtonTitleStyleUnder,    //标题在下边，图片在上边
    UIButtonTitleStyleAbove,    //标题在上边，图片在下边
    UIButtonTitleStyleLeft     //标题在左边，图片在右边
};

@interface UIButton (titleStyle)

+ (id)buttonWithImageNormal:(UIImage *)imageNormal imageDisable:(UIImage *)imageDisable target:(id)target action:(SEL)selector;
+ (id)buttonWithTitle:(NSString *)title titleColor:(UIColor *)colorNormal titleHightedColor:(UIColor *)colorHighted target:(id)target action:(SEL)selector;
/*
 *  @brief: 同时设置image和title，title显示在image的上方
 *  @param:
 *      size: UIButton大小， 默认40*40
 *      font: 标题字体大小，默认14号
 */
+ (id)buttonWithTitle:(NSString *)title titleColor:(UIColor *)color titleFont:(UIFont *)font imageNormal:(UIImage *)imageNormal imageDisable:(UIImage *)imageDisable target:(id)target action:(SEL)selector size:(CGSize)size;
/*
 *  @brief: 同时设置image和title，title显示在image的下方
 *      size: UIButton大小， 默认40*40
 */
+ (id)buttonWithImageNormal:(UIImage *)imageNormal imageDisable:(UIImage *)imageDisable title:(NSString *)title titleColor:(UIColor *)color target:(id)target action:(SEL)selector size:(CGSize)size;
/*
 *  @brief: 设置图片和标题显示风格
 *      titleStyle:
 *      fIndent: 标题和图片的间隔
 */
- (void)setTitleStyle:(UIButtonTitleStyle)titleStyle indent:(CGFloat)fIndent;

@end