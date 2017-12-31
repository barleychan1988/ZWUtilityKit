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

- (void)setLeftIcon:(UIImage *)image padding:(CGFloat)leftWidth
{    
    UIImageView *imageViewIcon = [[UIImageView alloc] initWithImage:image];
    imageViewIcon.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageViewIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    UIView *viewLockIcon = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width + leftWidth * 2, self.bounds.size.height)];
    viewLockIcon.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.leftView = viewLockIcon;
    self.leftViewMode = UITextFieldViewModeAlways;
    [viewLockIcon addSubview:imageViewIcon];
}

@end
