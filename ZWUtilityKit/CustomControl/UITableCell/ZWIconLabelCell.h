//
//  ZWIconLabelCell.h
//  Pods
//
//  Created by EadkennyChan on 17/5/30.
//
//

#import "ZWAccessoryCell.h"

NS_ASSUME_NONNULL_BEGIN

/*
 *  @brief： 图标、文本
 */
UIKIT_EXTERN  NSString *_Nonnull const ZWIconLabelCellID;

@interface ZWIconLabelCell : ZWAccessoryCell
{
}
@property (nonatomic, retain, nullable)UIImage *icon;
@property (nonatomic, readonly, retain)UILabel *textLabel;
@property (nonatomic, retain)NSString *text;
@property (nonatomic, assign)CGFloat fWidthDiff; //图标和文字之间的间距

@end

UIKIT_EXTERN  NSString *_Nonnull const ZWIconLLCellID;

@interface ZWIconLLCell : ZWIconLabelCell
{
}
@property (nonatomic, assign)CGFloat fTextWidth;  // 提示文字所占宽度
@property (nonatomic, readonly, retain)UILabel *detailTextLabel;

@end

UIKIT_EXTERN  NSString *_Nonnull const ZWIconLabelTFCellID;

@interface ZWIconLabelTFCell : ZWIconLabelCell
{
}
@property (nonatomic, assign)CGFloat fTextWidth;  // 提示文字所占宽度
@property (nonatomic, readonly, retain)UITextField *detailTextField;

@end

NS_ASSUME_NONNULL_END
