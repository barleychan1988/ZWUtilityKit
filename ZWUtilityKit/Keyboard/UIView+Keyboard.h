//
//  UIView+Keybord.h
//  ZWUtilityKit
//
//  Created by chenzw on 15/9/10.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Keyboard)
/*
 *  @brief:注册键盘监听，必须与unregisterKeybordNotification成对调用
 */
- (void)registerKeybordNotification;
/*
 *  @brief:注销键盘监听
 */
- (void)unregisterKeybordNotification;

@end
