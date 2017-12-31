//
//  UITextField+LeftPadding.h
//  Pods
//
//  Created by EadkennyChan on 17/7/4.
//
//

#import <UIKit/UIKit.h>

@interface UITextField (LeftPadding)

- (void)setLeftPadding:(CGFloat)leftWidth;
- (void)setLeftIcon:(nonnull UIImage *)image padding:(CGFloat)leftWidth;
- (void)setLeftIcon:(nonnull UIImage *)image paddingLeft:(CGFloat)leftWidth paddingRight:(CGFloat)rightWidth;

- (void)setPlaceholder:(nonnull NSString *)strPlaceholder withColor:(nonnull UIColor *)color;

@end
