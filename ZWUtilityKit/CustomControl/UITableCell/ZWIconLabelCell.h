//
//  ZWIconLabelCell.h
//  Pods
//
//  Created by EadkennyChan on 17/5/30.
//
//

#import "ZWAccessoryCell.h"

/*
 *  @brief： 图标、文本
 */
UIKIT_EXTERN  NSString *_Nonnull const ZWIconLabelCellID;

@interface ZWIconLabelCell : ZWAccessoryCell
{
}
@property (nonatomic, retain)UIImage *icon;
@property (nonatomic, readonly, retain)UILabel *textLabel;
@property (nonatomic, retain)NSString *text;
@property (nonatomic, assign)CGFloat fTextWidth;
@property (nonatomic, assign)CGFloat fWidthDiff; //图标和文字之间的间距

@end

UIKIT_EXTERN  NSString *_Nonnull const ZWIconLLCellID;

@interface ZWIconLLCell : ZWIconLabelCell
{
}
@property (nonatomic, readonly, retain)UILabel *detailTextLabel;

@end

UIKIT_EXTERN  NSString *_Nonnull const ZWIconLabelTFCellID;

@interface ZWIconLabelTFCell : ZWIconLabelCell
{
}
@property (nonatomic, readonly, retain)UITextField *detailTextField;

@end
