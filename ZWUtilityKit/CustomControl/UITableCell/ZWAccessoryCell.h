//
//  ZWAccessoryCell.h
//  Pods
//
//  Created by EadkennyChan on 17/6/9.
//
//

#import "ZWSeperatorLineCell.h"

@interface ZWAccessoryCell : ZWSeperatorLineCell

@property (nonatomic, assign)CGFloat fWidthRight; //右边距离边界宽度 default is 15.

- (void)showAccessory:(BOOL)bShow image:(nullable UIImage *)image;

- (void)showCustomAccessory:(nonnull UIView *)view withSize:(CGSize)size;
- (void)hiddenAccessory;

@end
