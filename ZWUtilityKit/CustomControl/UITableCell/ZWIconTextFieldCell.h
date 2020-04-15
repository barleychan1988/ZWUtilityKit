//
//  ZWIconTextFieldCell.h
//  Pods
//
//  Created by EadkennyChan on 17/6/12.
//
//

#import "ZWAccessoryCell.h"
#import "ZWTextField.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN  NSString *_Nonnull const ZWIconTextFieldCellID;

@interface ZWIconTextFieldCell : ZWAccessoryCell

@property (nonatomic, retain, nullable)UIImage *icon;
@property (nonatomic, readonly, retain, nonnull)ZWTextField *textField;
@property (nonatomic, assign)CGFloat fWidthDiff; //图标和文字之间的间距

@end

NS_ASSUME_NONNULL_END
