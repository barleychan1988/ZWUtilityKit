//
//  ViewController.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/12/21.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWMacroDef.h"

@interface UIViewController (ZWExt)

/*
 *  @brief： 显示弹窗
 *      弹窗最多可以显示两个按钮
 */
- (id)showAlert:(id<UIAlertViewDelegate>)delegate message:(NSString *)strMsg title:(NSString *)strTitle okButton:(NSString *)strTitleOk okAction:(BlockVoid)handleOk cancelButton:(NSString *)strTitleCancel cancelAction:(BlockVoid)handleCancel;
/*
 *  @brief： 显示弹窗
 *      弹窗最多可以显示两个按钮
 *      可以设置标题和消息内容的颜色字体等
 *
     NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:strTitle];
     [attrTitle addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, strTitle.length)];
     [attrTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, strTitle.length)];
 */
- (id)showAlert:(id<UIAlertViewDelegate>)delegate attributeMsg:(NSAttributedString *)attrStrMsg attributeTitle:(NSAttributedString *)attrStrTitle okButton:(NSString *)strTitleOk okAction:(BlockVoid)handleOk cancelButton:(NSString *)strTitleCancel cancelAction:(BlockVoid)handleCancel;
/*
 *  @brief： 显示弹窗
 *      弹窗最多可以显示两个按钮
 *      可以设置确定和取消按钮的颜色
 *
 NSMutableAttributedString *attrOkTitle = [[NSMutableAttributedString alloc] initWithString:strTitle];
 [attrTitle addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, strTitle.length)];
 */
- (id)showAlert:(id<UIAlertViewDelegate>)delegate attributeMsg:(NSAttributedString *)attrStrMsg attributeTitle:(NSAttributedString *)attrStrTitle attributeOkButton:(NSString *)strTitleOk okAction:(BlockVoid)handleOk attributeCancelButton:(NSString *)strTitleCancel cancelAction:(BlockVoid)handleCancel;

@end
