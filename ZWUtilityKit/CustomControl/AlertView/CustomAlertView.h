//
//  CustomAlertView.h
//  TestNav
//
//  Created by 陈正旺 on 15/3/13.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView

@property(nonatomic, retain)UIColor *colorSeparatorLine;//按钮分割线 default:RGB(158,158,158)
@property(nonatomic, retain)UIColor *colorBtnTitle;//按钮标题颜色 default:RGB(56,56,56)
@property(nonatomic, retain)NSString *strTitle;
@property(nonatomic, retain)NSString *strMessage;
@property(nonatomic, retain)NSAttributedString *attributedMessage;
@property(nonatomic, retain)UIView *viewAddtion;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (void)show;

@end