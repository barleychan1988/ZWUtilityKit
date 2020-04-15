//
//  ZWLabelTextViewCell.h
//  SCBase
//
//  Created by Eadkenny on 2018/1/19.
//

#import "ZWSeperatorLineCell.h"
//#import "UITextView+Placeholder.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN  NSString *_Nonnull const ZWLabelTextViewCellID;

@interface ZWLabelTextViewCell : ZWSeperatorLineCell

@property (nonatomic, readonly, retain, nonnull)UILabel *labelTextTip;//14.font 170.color
@property (nonatomic, readonly, retain, nonnull)UITextView *textViewContent;

@property (nonatomic, retain, nullable)NSString *text;
@property (nonatomic, assign)CGFloat fTextWidth;
@property (nonatomic, assign)CGFloat fHeightTipView; //
@property (nonatomic, assign)CGFloat fContentViewTopOffset;

@end

NS_ASSUME_NONNULL_END
