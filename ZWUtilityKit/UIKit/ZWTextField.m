//
//  ZWTextField.m
//  ZWUtilityKit
//
//  Created by  eadkenny on 2020/3/31.
//  Copyright © 2020 zwchen. All rights reserved.
//

#import "ZWTextField.h"

@interface ZWTextField ()
@property (nonatomic, assign)CGSize rightViewSize;
@property (nonatomic, assign)CGSize leftViewSize;
@end

@implementation ZWTextField

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
  CGRect rect = [super rightViewRectForBounds:bounds];
  rect.size = _rightViewSize;
  rect.origin.x = bounds.size.width - rect.size.width;
  rect.origin.y = (bounds.size.height - rect.size.height) / 2;
  return rect;
}

- (void)setRightView:(UIView *)rightView {
  [super setRightView:rightView];
  self.rightViewSize = rightView.frame.size;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
  CGRect rect = [super leftViewRectForBounds:bounds];
  rect.size = _leftViewSize;
  rect.origin.x = 0;
  rect.origin.y = (bounds.size.height - rect.size.height) / 2;
  return rect;
}

- (void)setLeftView:(UIView *)leftView {
  [super setLeftView:leftView];
  self.leftViewSize = leftView.frame.size;
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  if (enabled) {
    self.textColor = self.normalTextColor;
  } else {
    self.textColor = self.disableTextColor;
  }
}

- (void)setNormalTextColor:(UIColor *)color {
  _normalTextColor = color;
  self.textColor = color;
}

@end
