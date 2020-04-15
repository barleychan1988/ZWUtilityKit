//
//  EadSeparatorLineCell.h
//  Pods
//
//  Created by zwchen on 2017/6/22.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN  NSString *_Nonnull const EadSeparatorLineCellID;

@interface EadSeparatorLineCell : UITableViewCell

//如果颜色未nil，则默认(221,221,221)
- (void)showTopSeparatorLine:(BOOL)bShow color:(nullable UIColor *)color;
- (void)showTopSeparatorLine:(BOOL)bShow color:(nullable UIColor *)color indent:(CGFloat)fIndent;
- (void)showBottomSeparatorLine:(BOOL)bShow color:(nullable UIColor *)color;
- (void)showBottomSeparatorLine:(BOOL)bShow color:(nullable UIColor *)color indent:(CGFloat)fIndent;

@property (nonatomic, assign)UIEdgeInsets contentInset;//默认(0,15,0,15)
@property (nonatomic, retain, readonly)UIView * mainView;

@end

NS_ASSUME_NONNULL_END
