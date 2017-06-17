//
//  ZWIconTextFieldCell.h
//  Pods
//
//  Created by EadkennyChan on 17/6/12.
//
//

#import "ZWAccessoryCell.h"

UIKIT_EXTERN  NSString *_Nonnull const ZWIconTextFieldCellID;

@interface ZWIconTextFieldCell : ZWAccessoryCell

@property (nonatomic, retain)UIImage *icon;
@property (nonatomic, readonly, retain)UITextField *textField;
@property (nonatomic, assign)CGFloat fWidthDiff; //图标和文字之间的间距

@end
