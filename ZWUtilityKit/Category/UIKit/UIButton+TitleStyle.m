//
//  UIButton.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/4/17.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "UIButton+TitleStyle.h"
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

- (void)setTitleStyle:(UIButtonTitleStyle)titleStyle indent:(CGFloat)fIndent
{
    UIImage *image = [self imageForState:UIControlStateNormal];
    if (image == nil)
        image = [self imageForState:UIControlStateHighlighted];
    if (image == nil)
        image = self.imageView.image;
    if (image == nil)
        return;
    NSString *strTitle = [self titleForState:UIControlStateNormal];
    if (strTitle.length == 0)
        strTitle = [self titleForState:UIControlStateSelected];
    if (strTitle.length == 0)
        strTitle = self.titleLabel.text;
    if (strTitle.length == 0)
        return;
    
    CGSize szTitle = getSizeForLabel(strTitle, self.titleLabel.font, NSLineBreakByCharWrapping, CGSizeZero);
    UIEdgeInsets insets = UIEdgeInsetsZero;
    switch (titleStyle)
    {
        case UIButtonTitleStyleUnder://标题在下边，图片在上边
        {
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
            insets.top = (self.frame.size.height - image.size.height - szTitle.height - fIndent) / 2;
            insets.left = (self.frame.size.width - image.size.width) / 2;
            [self setImageEdgeInsets:insets];
            insets.top += (image.size.height + fIndent);
            insets.left = (self.frame.size.width - szTitle.width) / 2 - image.size.width;
            [self setTitleEdgeInsets:insets];
        }
        break;
        case UIButtonTitleStyleAbove://标题在上边，图片在下边
        {
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            
            CGFloat fDiff = (self.frame.size.height - image.size.height - szTitle.height ) / 3;
            insets.top = self.frame.size.height - image.size.height - fDiff;
            insets.left = (szTitle.width + image.size.width) / 2;
            [self setImageEdgeInsets:insets];
            insets.top = fDiff;
            insets.left = -(szTitle.width + image.size.width) / 2;
            [self setTitleEdgeInsets:insets];
        }
        break;
        case UIButtonTitleStyleLeft://标题在左边，图片在右边
        {
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            insets.left = (self.frame.size.width - image.size.width - szTitle.width) / 2 + szTitle.width + 5;
            [self setImageEdgeInsets:insets];
            insets.left = (self.frame.size.width - image.size.width - szTitle.width) / 2 - image.size.width;
            [self setTitleEdgeInsets:insets];
        }
        break;
        default:
        {
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            insets.left = (self.frame.size.width - image.size.width - szTitle.width - fIndent) / 2;
            [self setImageEdgeInsets:insets];
            insets.left += fIndent;
            [self setTitleEdgeInsets:insets];
        }
        break;
    }
}

@end
