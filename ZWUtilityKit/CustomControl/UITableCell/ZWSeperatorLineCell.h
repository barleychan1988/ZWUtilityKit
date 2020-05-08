//
//  ZWSeperatorLineCell.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/5/29.
//  Copyright © 2017年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN  NSString *_Nonnull const ZWSeperatorLineCellID;

NS_ASSUME_NONNULL_BEGIN
/*
 *  @brief： 分割线管理cell
 */
@interface ZWSeperatorLineCell : UITableViewCell

- (void)initValues;
- (void)initSubviews;

//如果颜色未nil，则默认(221,221,221)
- (void)showTopSeparatorLine:(BOOL)bShow color:(nullable UIColor *)color;
- (void)showTopSeparatorLine:(BOOL)bShow color:(nullable UIColor *)color indent:(CGFloat)fIndent;
- (void)showBottomSeparatorLine:(BOOL)bShow color:(nullable UIColor *)color;
- (void)showBottomSeparatorLine:(BOOL)bShow color:(nullable UIColor *)color indent:(CGFloat)fIndent;

/*
 *  @brief：显示顶部分割线
 *  @param：
 *      color ： 分割线颜色
 *      fHeight : 高度
 *      fIndent : 缩进
 */
- (void)showTopLineWithColor:(nullable UIColor *)color height:(CGFloat)fHeight;
- (void)showTopLineWithColor:(nullable UIColor *)color height:(CGFloat)fHeight indent:(CGFloat)fIndent;
- (void)showTopLineWithImage:(nonnull UIImage *)image height:(CGFloat)fHeight;
- (void)showTopLineWithImage:(nonnull UIImage *)image height:(CGFloat)fHeight indent:(CGFloat)fIndent;
- (void)hiddenTopLine;
- (void)showBottomLineWithColor:(nullable UIColor *)color height:(CGFloat)fHeight;
- (void)showBottomLineWithColor:(nullable UIColor *)color height:(CGFloat)fHeight indent:(CGFloat)fIndent;
- (void)showBottomLineWithImage:(nonnull UIImage *)image height:(CGFloat)fHeight;
- (void)showBottomLineWithImage:(nonnull UIImage *)image height:(CGFloat)fHeight indent:(CGFloat)fIndent;
- (void)hiddenBottomLine;

@property (nonatomic, assign)UIEdgeInsets contentInset;
@property (nonatomic, assign)BOOL isSelectedBackgroundSameWithContent; //default is YES.

@property (nonatomic, retain, readonly, nullable)UIView *topSeparatorLine;
@property (nonatomic, retain, readonly, nullable)UIView *bottomSeparatorLine;

+ (UIColor *)defaultSeperatorLineColor;

@end

NS_ASSUME_NONNULL_END
