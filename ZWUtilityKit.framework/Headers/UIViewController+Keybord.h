//
//  Keybord.h
//  ZWUtilityKit
//
//  Created by 陈正旺 on 14/12/12.
//  Copyright (c) 2014年 zwchen. All rights reserved.
//

/* ------------------------------------------------------
 *
 * @description：处理UIViewController中View上控件成为响应者弹出
 *  键盘时遮挡响应者控件问题；
 *
 * @update time: 2014-12-12
 *
 * ------------------------------------------------------*/

#import <UIKit/UIKit.h>

@interface UIViewController(Keyboard)
/*
 *  @brief:注册键盘监听，必须与unregisterKeybordNotification成对调用
 */
- (void)registerKeyboardNotification;
/*
 *  @brief:注销键盘监听
 */
- (void)unregisterKeyboardNotification;

@end