/*
 * Copyright (c) EadkennyChan
 * All rights reserved.
 *
 * 文件名称：filename.h
 * 文件标识：见配置管理计划书
 * 摘要：the function of this category is adding line on view.
 *
 * 当前版本：3.0
 * 作 者：EadkennyChan
 * 完成日期：2013.12.06
 * 修改日期：2016.12.28
 *
 */

#import <UIKit/UIKit.h>

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)

@interface UIView(AddLine)

#pragma mark 一个像素宽的分割线
/*
 *  @description:在View的上边栏添加一个像素宽的分割线
 *  @param [in]:color:分割线的颜色；
 *              indent:分割线缩进；
 *  @ret: 线条View
 */
- (UIView *)addTopUnitPixLine:(UIColor *)color;
- (UIView *)addTopUnitPixLine:(UIColor *)color indent:(CGFloat)fIndent;
- (UIView *)addBottomUnitPixLine:(UIColor *)color;
- (UIView *)addBottomUnitPixLine:(UIColor *)color indent:(CGFloat)fIndent;
- (UIView *)addLeftUnitPixLine:(UIColor *)color;
- (UIView *)addLeftUnitPixLine:(UIColor *)color indent:(CGFloat)fIndent;
- (UIView *)addRightUnitPixLine:(UIColor *)color;
- (UIView *)addRightUnitPixLine:(UIColor *)color indent:(CGFloat)fIndent;
/*
 *  @description:在View的上边栏添加横线
 *  @param [in]:width:线条的粗度；color:线条的颜色
 *  @ret: 线条View
 */
- (UIView *)addTopLineWithWidth:(CGFloat)width color:(UIColor *)color;
- (UIView *)addTopUnitPixLine2:(UIColor *)color;
- (UIView *)addTopUnitPixLine2:(UIColor *)color indent:(CGFloat)fIndent;

/*
 *  @description:在View的下边栏添加横线
 *  @param [in]:width:线条的粗度；color:线条的颜色
 *  @ret: 线条View
 */
- (UIView *)addBottomLineWithWidth:(CGFloat)width color:(UIColor *)color;
- (UIView *)addBottomUnitPixLine2:(UIColor *)color;
- (UIView *)addBottomLineWithWidth:(CGFloat)width color:(UIColor *)color indent:(CGFloat)fIndent;
- (UIView *)addBottomUnitPixLine2:(UIColor *)color indent:(CGFloat)fIndent;
/*
 *  @description:在View的右边栏添加竖线
 *  @param [in]:width:线条的粗度；color:线条的颜色
 *  @ret: 线条View
 */
- (UIView *)addRightLineWithWidth:(CGFloat)width color:(UIColor *)color;
- (UIView *)addRightUnitPixLine2:(UIColor *)color;
- (UIView *)addLeftUnitPixLine2:(UIColor *)color;
/*
 *  @description:在View的x开始位置上添加竖线
 *  @param [in]:width:线条的宽度；color:线条的颜色
 *  @ret: 线条View
 */
- (UIView *)addVerticalLineWithWidth:(CGFloat)width color:(UIColor *)color atX:(CGFloat)x;
/*
 *  @description:在View的x开始位置上添加单位像素宽的竖线
 *  @param [in]:width:线条的宽度；color:线条的颜色
 *  @ret: 线条View
 */
- (UIView *)addVerticalUnitPixLine:(UIColor *)color atX:(CGFloat)x;
/*
 *  @description:在View的y开始位置上添加横线
 *  @param [in]:height:线条的宽度；color:线条的颜色
 *  @ret: 线条View
 */
- (UIView *)addHorizontalLineWithHeight:(CGFloat)height color:(UIColor *)color atY:(CGFloat)y;
/*
 *  @description:在View的x开始位置上添加单位像素宽的横线
 *  @param [in]:width:线条的宽度；color:线条的颜色
 *  @ret: 线条View
 */
- (UIView *)addHorizontalUnitPixLine:(UIColor *)color atY:(CGFloat)y;
/*
 *  @description:在View上的矩形区内添加指定颜色的View
 *  @param [in]:rect:矩形区；color:矩形区颜色
 *  @ret: 线条View
 */
- (UIView *)addLineWithRect:(CGRect)rect color:(UIColor *)color;

@end