//
//  Keybord.m
//  ZWUtilityKit
//
//  Created by 陈正旺 on 14/12/12.
//  Copyright (c) 2014年 zwchen. All rights reserved.
//

#import "UIViewController+Keybord.h"

@implementation UIViewController(Keyboard)

CGRect g_rectOrigin;    //self.view原位置
BOOL g_bFlag = NO;

- (void)registerKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)unregisterKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
    
    UIView *firstResponder = [self findFirstResponderBeneathView:self.view];
    if (!firstResponder)
    {
        // No child view is the first responder - nothing to do here
        return;
    }
    
    g_bFlag = YES;
    
    if (CGRectEqualToRect(g_rectOrigin, CGRectZero))
    {
        g_rectOrigin = self.view.frame;
    }
    UIView *superView = [firstResponder superview];
    CGRect rectResponder = firstResponder.frame;
    rectResponder = [superView convertRect:rectResponder toView:nil];
    if ((rectResponder.origin.y + rectResponder.size.height) >= _keyboardRect.origin.y)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - rectResponder.origin.y + _keyboardRect.origin.y - rectResponder.size.height, g_rectOrigin.size.width, g_rectOrigin.size.height);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    if (g_bFlag)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = g_rectOrigin;
        }];
        g_rectOrigin = CGRectZero;
        g_bFlag = NO;
    }
}

@end