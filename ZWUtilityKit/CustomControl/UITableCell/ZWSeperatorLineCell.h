//
//  ZWSeperatorLineCell.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/5/29.
//  Copyright © 2017年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN  NSString *_Nonnull const ZWSeperatorLineCellID;
/*
 *  @brief： 分割线管理cell
 */
@interface ZWSeperatorLineCell : UITableViewCell

//如果颜色未nil，则默认(221,221,221)
- (void)showTopSeparatorLine:(BOOL)bShow color:(nullable UIColor *)color;
- (void)showTopSeparatorLine:(BOOL)bShow color:(nullable UIColor *)color indent:(CGFloat)fIndent;
- (void)showBottomSeparatorLine:(BOOL)bShow color:(nullable UIColor *)color;
- (void)showBottomSeparatorLine:(BOOL)bShow color:(nullable UIColor *)color indent:(CGFloat)fIndent;

@property (nonatomic, assign)UIEdgeInsets contentInset;

@end
