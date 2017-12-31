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

- (void)setPlaceholder:(nonnull NSString *)strPlaceholder withColor:(nonnull UIColor *)color;

@end
