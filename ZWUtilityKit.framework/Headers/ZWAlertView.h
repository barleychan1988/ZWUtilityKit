//
//  ZWAlertView.h
//  ZWUtilityKit
//
//  Created by chenzw on 15/9/14.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//
/*
 *
 * @description：UIAlertView的改进版，支持Message部分可以格式自定义
 *
 * @update time: 2015-09-14
 *
 */
#import <UIKit/UIKit.h>

@interface ZWAlertView : UIScrollView
{
    UIAlertView *m;
}

- (void)tapMessageTarget:(id)target action:(SEL)aSelector;

- (instancetype)initWithTitle:(NSString *)title message:(NSAttributedString *)message delegate:(id /**<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... ;

- (void)show;

@end
