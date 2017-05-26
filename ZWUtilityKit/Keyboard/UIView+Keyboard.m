//
//  UIView+Keybord.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/9/10.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "UIView+Keyboard.h"
#import <objc/runtime.h>

@implementation UIView (Keyboard)

CGPoint g_posOrigin;    //self原位置

- (void)registerKeybordNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self setKeyboardShowFlage:NO];
}

- (void)unregisterKeybordNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    objc_removeAssociatedObjects(self);
}
/*
 *  @brief：查找view子窗口及嵌套子窗口中的第一响应者
 *  @ret：第一响应者，若无则返回nil
 */
- (UIView*)findFirstResponderBeneathView:(UIView*)view
{
    // Search recursively for first responder
    for ( UIView *childView in view.subviews )
    {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] )
        {
            return childView;
        }
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result )
        {
            return result;
        }
    }
    return nil;
}

#define _UIKeyboardFrameEndUserInfoKey (&UIKeyboardFrameEndUserInfoKey != NULL ? UIKeyboardFrameEndUserInfoKey : @"UIKeyboardBoundsUserInfoKey")

- (void)keyboardWillShow:(NSNotification*)notification
{
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIView *firstResponder = [self findFirstResponderBeneathView:self];
    if (!firstResponder)
    {
        // No child view is the first responder - nothing to do here
        return;
    }
    
    
    if (![self isKeyboardShow])
    {
        g_posOrigin = self.frame.origin;
    }
    [self setKeyboardShowFlage:YES];
    
    UIView *superView = [firstResponder superview];
    CGRect rectResponder = firstResponder.frame;
    rectResponder = [superView convertRect:rectResponder toView:nil];
    if ((rectResponder.origin.y + rectResponder.size.height) >= _keyboardRect.origin.y)
    {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.frame;
            frame.origin.y = self.frame.origin.y - rectResponder.origin.y + _keyboardRect.origin.y - rectResponder.size.height;
            self.frame = frame;
        }];
    }
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    if ([self isKeyboardShow])
    {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame;
            frame.origin = g_posOrigin;
            frame.size = self.frame.size;
            self.frame = frame;
        }];
        g_posOrigin = CGPointZero;
        [self setKeyboardShowFlage:NO];
    }
}

#pragma mark private

static char UIViewKeyboard_flag;

- (BOOL)isKeyboardShow
{
    NSNumber *numFlag = objc_getAssociatedObject(self, &UIViewKeyboard_flag);
    return numFlag.boolValue;
}

- (void)setKeyboardShowFlage:(BOOL)isShow
{
    NSNumber *numFlag = [NSNumber numberWithBool:isShow];
    objc_setAssociatedObject(self, &UIViewKeyboard_flag, numFlag, OBJC_ASSOCIATION_ASSIGN);
}

@end