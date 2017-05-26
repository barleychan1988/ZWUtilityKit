//
//  InputButton.m
//  TTRental
//
//  Created by 陈正旺 on 15/1/7.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "ZWInputButton.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
                do { \
                _Pragma("clang diagnostic push") \
                _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
                Stuff; \
                _Pragma("clang diagnostic pop") \
                } while (0)

@interface ZWInputButton()
{
    UIView *m_viewAlpha;
}

@end

@implementation ZWInputButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)inputAccessoryView
{
    //    if (!_inputAccessoryView)
    if (!_myInputAccessoryView)
    {
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        toolbar.backgroundColor = [UIColor whiteColor];
        
        UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(btnClickedCancel:)];
        UIBarButtonItem *itemFlexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *itemOk = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(btnClickedOk:)];
        [toolbar setItems:[NSArray arrayWithObjects:itemCancel, itemFlexible, itemOk, nil] animated:YES];
        _myInputAccessoryView = toolbar;
    }
    return _myInputAccessoryView;
}

- (UIView *)inputView
{
    if (!_myInputView)
    {
        UIDatePicker *  pickView = [[UIDatePicker alloc] init];
        _myInputView = pickView;
    }
    return _myInputView;
}

- (BOOL)canBecomeFirstResponder
{
    UIControl *controlAlpha = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    controlAlpha.backgroundColor = [UIColor grayColor];
    controlAlpha.alpha = 0.5;
    [controlAlpha addTarget:self action:@selector(btnClickedCancel:) forControlEvents:UIControlEventTouchUpInside];
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    UIWindow *window;
    for (window in frontToBackWindows)
    {
        if (window.windowLevel == UIWindowLevelNormal)
        {
            [window addSubview:controlAlpha];
            break;
        }
    }
    m_viewAlpha = controlAlpha;
    
    return YES;
}

- (IBAction)btnClickedCancel:(id)sender
{
    if (_selCancel && [_delegate respondsToSelector:_selCancel])
    {
        SuppressPerformSelectorLeakWarning([_delegate performSelector:_selCancel withObject:_myInputView]);
    }
    [m_viewAlpha removeFromSuperview];
    [self resignFirstResponder];
}

- (IBAction)btnClickedOk:(id)sender
{
    if (_selOK && [_delegate respondsToSelector:_selOK])
    {
        SuppressPerformSelectorLeakWarning([_delegate performSelector:_selOK withObject:_myInputView]);
    }
    [m_viewAlpha removeFromSuperview];
    [self resignFirstResponder];    
}

@end
