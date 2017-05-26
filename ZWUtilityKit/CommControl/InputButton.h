//
//  InputButton.h
//  TTRental
//
//  Created by 陈正旺 on 15/1/7.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//
/* ------------------------------------------------------
 *
 * @description：UIButton对象成为第一响应者时弹出输入窗口
 *
 * @update time: 2015-01-07
 *
 * ------------------------------------------------------*/
#import <UIKit/UIKit.h>

@interface InputButton : UIButton

@property(nonatomic, strong)UIView *myInputAccessoryView;
@property(nonatomic, strong)UIView *myInputView;
//在默认的“确认”或“取消”后执行的操作
@property(nonatomic, strong)NSObject *delegate;
@property(nonatomic, assign)SEL selOK;
@property(nonatomic, assign)SEL selCancel;

@end