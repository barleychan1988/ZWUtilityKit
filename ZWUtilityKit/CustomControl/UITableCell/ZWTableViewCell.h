//
//  ZWTableViewCell.h
//  SuperCode
//
//  Created by chenpeng on 16/5/3.
//  Copyright © 2016年 chenzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWSeperatorLineCell.h"

/*
 *  @brief：左边是否显示红色*以表明是否必填
 *      右边是否显示箭头之类的提示
 */
@interface ZWRequiredTipCell : UITableViewCell

@property (nonatomic, retain, readonly, nullable)UILabel *labelRequired;
@property (nonatomic, assign)CGFloat fRequiredTipWidth;//
@property (nonatomic, assign)CGFloat fAccessoryWidth;//

//是否显示必填项提示符（红色*）
- (void)showRequiredTip:(BOOL)bShow;
- (void)showAccessoryImage:(BOOL)bShow image:(nullable UIImage *)image;

@end

#pragma mark -

typedef NS_ENUM(NSInteger, VerticalAlignment)
{
    VerticalAlignment_Middle = 0, // default
    VerticalAlignment_Top,
    VerticalAlignment_Bottom
};

UIKIT_EXTERN NSString *_Nonnull const ZWLabelTipCellID;

@interface ZWLabelTipCell : ZWSeperatorLineCell

@property (nonatomic, retain, readonly, nullable)UILabel *labelTip;
@property (nonatomic, assign)VerticalAlignment alignmentTipVertical;
@property (nonatomic, assign)CGFloat fWidthTip;

//是否现在必填项提示符（红色*）
- (void)showRequiredTip:(BOOL)bShow;
- (void)showAccessory:(BOOL)bShow customView:(nullable UIView *)view;
- (void)showAccessory:(BOOL)bShow image:(nullable NSString *)strImage;

@end

UIKIT_EXTERN NSString *_Nonnull const ZWLabelLabelCellID;

@interface ZWLabelLabelCell : ZWLabelTipCell
@property (nonatomic, retain, readonly, nullable)UILabel *labelContent;

@end

#pragma mark -

@protocol ZWLabelTFDelegate;

UIKIT_EXTERN NSString *_Nonnull const ZWLabelTFCellID;

@interface ZWLabelTFCell : ZWLabelTipCell

@property (nonatomic, retain, readonly, nullable)UITextField *tfContent;
@property (nullable, nonatomic, weak)id<ZWLabelTFDelegate> delegate;

@end

@protocol ZWLabelTFDelegate <NSObject>

- (void)labelTfDidEndEditing:(nonnull ZWLabelTFCell *)labelTF;

@end
