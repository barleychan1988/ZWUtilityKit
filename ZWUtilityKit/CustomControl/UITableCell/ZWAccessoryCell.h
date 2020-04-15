//
//  ZWAccessoryCell.h
//  Pods
//
//  Created by EadkennyChan on 17/6/9.
//
//

#import "ZWSeperatorLineCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZWAccessoryCell : ZWSeperatorLineCell

@property (nonatomic, assign)CGFloat fWidthRight; //右边距离边界宽度 default is 15.
- (CGFloat)widthOfAccessory;

- (void)showAccessory:(BOOL)bShow image:(nullable UIImage *)image;
- (void)showAccessory:(BOOL)bShow imageName:(nullable NSString *)imageName;

- (void)showCustomAccessory:(UIView *)view withSize:(CGSize)size;
- (void)showCustomAccessory:(UIView *)view;
- (void)hiddenAccessory;

@end

NS_ASSUME_NONNULL_END
