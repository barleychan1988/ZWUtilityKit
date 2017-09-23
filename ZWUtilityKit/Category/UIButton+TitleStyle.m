//
//  UIButton.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/4/17.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "UIButton+TitleStyle.h"
#import <objc/runtime.h>
#import "UtilityUIKit.h"

//@interface UIButton ()
//
////此方法调用必须在设置好image和frame后
//- (void)setTitleStyle:(UIButtonTitleStyle)titleStyle;
//
//@end


@implementation UIButton (titleStyle)

+ (id)buttonWithImageNormal:(UIImage *)imageNormal imageDisable:(UIImage *)imageDisable target:(id)target action:(SEL)selector
{
    UIButton *btn = [[self class] buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:imageNormal forState:UIControlStateNormal];
    if (imageDisable)
        [btn setImage:imageDisable forState:UIControlStateDisabled];
    return btn;
}

+ (id)buttonWithTitle:(NSString *)title titleColor:(UIColor *)colorNormal titleHightedColor:(UIColor *)colorHighted target:(id)target action:(SEL)selector
{
    UIButton *btn = [[self class] buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:colorNormal forState:UIControlStateNormal];
    if (colorHighted)
        [btn setTitleColor:colorHighted forState:UIControlStateHighlighted];
    return btn;
}

+ (id)buttonWithTitle:(NSString *)title titleColor:(UIColor *)color titleFont:(UIFont *)font imageNormal:(UIImage *)imageNormal imageDisable:(UIImage *)imageDisable target:(id)target action:(SEL)selector size:(CGSize)size
{
    UIButton *btn = [[self class] buttonWithType:UIButtonTypeCustom];
    if (title.length > 0)
        [btn setTitle:title forState:UIControlStateNormal];
    if (color)
        [btn setTitleColor:color forState:UIControlStateNormal];
    if (font)
        btn.titleLabel.font = font;
    else
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (imageNormal)
        [btn setImage:imageNormal forState:UIControlStateNormal];
    if (imageDisable)
        [btn setImage:imageDisable forState:UIControlStateDisabled];
    if (size.width <= 0)
        size.width = 40;
    if (size.height <= 0)
        size.height = 40;
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    CGSize szTitle = getSizeForLabel(title, btn.titleLabel.font, NSLineBreakByCharWrapping, CGSizeZero);
    
    CGFloat fDiff = (btn.frame.size.height - imageNormal.size.height - szTitle.height ) / 3;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(btn.frame.size.height - imageNormal.size.height - fDiff, (szTitle.width + imageNormal.size.width) / 2, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(fDiff, -(szTitle.width + imageNormal.size.width) / 2, 0, 0)];
    
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
/*
 *  @brief: 同时设置image和title，title显示在image的下方
 */
+ (id)buttonWithImageNormal:(UIImage *)imageNormal imageDisable:(UIImage *)imageDisable title:(NSString *)title titleColor:(UIColor *)color target:(id)target action:(SEL)selector size:(CGSize)size
{
    UIButton *btn = [[self class] buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    if (color)
        [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setImage:imageNormal forState:UIControlStateNormal];
    if (imageDisable)
        [btn setImage:imageDisable forState:UIControlStateDisabled];
    if (size.width <= 0)
        size.width = 40;
    if (size.height <= 0)
        size.height = 40;
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    CGSize szTitle = getSizeForLabel(title, btn.titleLabel.font, NSLineBreakByCharWrapping, CGSizeZero);
    UIEdgeInsets insets = UIEdgeInsetsMake((btn.frame.size.height - imageNormal.size.height - szTitle.height) / 2, (btn.frame.size.width - imageNormal.size.width) / 2, 0, 0);
    if (insets.left < 0)
    {
        insets.left = 0;
    }
    [btn setImageEdgeInsets:insets];
    insets = UIEdgeInsetsMake((imageNormal.size.height + btn.frame.size.height - szTitle.height) / 2 + 3, (btn.frame.size.width - szTitle.width) / 2 - imageNormal.size.width, 0, 0);
    [btn setTitleEdgeInsets:insets];
    
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self.class, @selector(layoutSubviews)),
                                   class_getInstanceMethod(self.class, @selector(swizzled_layoutSubviews)));
}

- (void)swizzled_layoutSubviews
{
    [self swizzled_layoutSubviews];
    
    CGRect frame;
    UIButtonTitleStyle titleStyle = ((NSNumber *)objc_getAssociatedObject(self, &strKeyTitleStyle)).intValue;
    CGFloat fDiffWidth = ((NSNumber *)objc_getAssociatedObject(self, &strKeyDiffWidth)).floatValue;
    switch (titleStyle)
    {
        case UIButtonTitleStyleUnder://标题在下边，图片在上边
        {
            CGRect frameTitleLabel = self.titleLabel.frame;
            if (frameTitleLabel.size.height == 0)
            {
                frameTitleLabel.size.height = getSizeForLabelText(self.titleLabel.text, self.titleLabel.font, CGSizeZero).height;
            }
            if (frameTitleLabel.size.width == 0)
            {
                frameTitleLabel.size.width = getSizeForLabelText(self.titleLabel.text, self.titleLabel.font, CGSizeZero).width;
            }
            frame.size = self.imageView.frame.size;
            frame.origin.x = (self.bounds.size.width - frame.size.width) / 2;
            frame.origin.y = (self.bounds.size.height - frame.size.height - fDiffWidth - frameTitleLabel.size.height) / 2;
            self.imageView.frame = frame;
            
            frame.origin.y += (frame.size.height + fDiffWidth);
            frame.size.height = frameTitleLabel.size.height;
            frame.origin.x = self.bounds.origin.x;
            frame.size.width = self.bounds.size.width;
            self.titleLabel.frame = frame;
        }
            break;
        case UIButtonTitleStyleAbove://标题在上边，图片在下边
        {
            CGRect frameTitleLabel = self.titleLabel.frame;
            if (frameTitleLabel.size.height == 0)
            {
                frameTitleLabel.size.height = getSizeForLabelText(self.titleLabel.text, self.titleLabel.font, CGSizeZero).height;
            }
            if (frameTitleLabel.size.width == 0)
            {
                frameTitleLabel.size.width = getSizeForLabelText(self.titleLabel.text, self.titleLabel.font, CGSizeZero).width;
            }
            frame.size = frameTitleLabel.size;
            frame.origin.x = (self.bounds.size.width - frame.size.width) / 2;
            frame.origin.y = (self.bounds.size.height - frame.size.height - fDiffWidth - self.imageView.frame.size.height) / 2;
            self.titleLabel.frame = frame;
            
            frame.origin.y += (frame.size.height + fDiffWidth);
            frame.size.height = self.titleLabel.frame.size.height;
            frame.origin.x = self.bounds.origin.x;
            frame.size.width = self.bounds.size.width;
            self.imageView.frame = frame;
        }
            break;
        case UIButtonTitleStyleLeft://标题在左边，图片在右边
        {
            frame.size = self.titleLabel.frame.size;
            frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
            frame.origin.x = (self.bounds.size.width - frame.size.width - self.imageView.frame.size.width - fDiffWidth) / 2;
            self.titleLabel.frame = frame;
            
            frame.origin.x += (frame.size.width + fDiffWidth);
            frame.size = self.imageView.frame.size;
            frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
            self.imageView.frame = frame;
        }
            break;
        case UIButtonTitleStyleRight://标题在右边，图片在左边
        {
            frame.size = self.imageView.frame.size;
            frame.origin.y = self.imageView.frame.origin.y;
            frame.origin.x = (self.bounds.size.width - frame.size.width - self.titleLabel.frame.size.width - fDiffWidth) / 2;
            self.imageView.frame = frame;
            
            frame.origin.x += (fDiffWidth + frame.size.width);
            frame.size = self.titleLabel.frame.size;
            frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
            self.titleLabel.frame = frame;
        }
            break;
        default:
        {
        }
            break;
    }
}

NSString *const strKeyTitleStyle = @"kTitleStyle";
NSString *const strKeyDiffWidth = @"kTitleImageDiffWidth";

- (void)setTitleStyle:(UIButtonTitleStyle)titleStyle indent:(CGFloat)fIndent
{
    objc_setAssociatedObject(self, &strKeyTitleStyle, [NSNumber numberWithInt:titleStyle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &strKeyDiffWidth, [NSNumber numberWithFloat:fIndent], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self removeConstraints:self.constraints];
    switch (titleStyle)
    {
        case UIButtonTitleStyleUnder://标题在下边，图片在上边
        case UIButtonTitleStyleAbove://标题在上边，图片在下边
        {
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
        break;
        case UIButtonTitleStyleLeft://标题在左边，图片在右边
        case UIButtonTitleStyleRight://标题在右边，图片在左边
        {
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        default:
        {
        }
        break;
    }
}

@end
