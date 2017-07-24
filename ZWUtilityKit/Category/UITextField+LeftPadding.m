//
//  UITextField+LeftPadding.m
//  Pods
//
//  Created by EadkennyChan on 17/7/4.
//
//

#import "UITextField+LeftPadding.h"

@implementation UITextField (LeftPadding)

- (void)setLeftPadding:(CGFloat)leftWidth
{
    CGRect frame = self.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

@end
