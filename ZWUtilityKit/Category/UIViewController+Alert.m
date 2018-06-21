//
//  ViewController.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/12/21.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (ZWExt)

- (id)showAlert:(id<UIAlertViewDelegate>)delegate message:(NSString *)strMsg title:(NSString *)strTitle okButton:(NSString *)strTitleOk okAction:(BlockObject)handleOk cancelButton:(NSString *)strTitleCancel cancelAction:(BlockObject)handleCancel
{
    if (@available(iOS 8.0, *))
    {
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:strTitle message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        if (strTitleCancel.length > 0)
        {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:strTitleCancel style:UIAlertActionStyleCancel handler:handleCancel];
            [sheet addAction:cancelAction];
        }
        if (strTitleOk.length > 0)
        {
            UIAlertAction *actionSetting = [UIAlertAction actionWithTitle:strTitleOk style:UIAlertActionStyleDefault handler:handleOk];
            [sheet addAction:actionSetting];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{[self presentViewController:sheet animated:YES completion:nil];});
        return sheet;
    }
    else
    {
        UIAlertView *sheet = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:delegate cancelButtonTitle:strTitleCancel otherButtonTitles:strTitleOk, nil];
        dispatch_async(dispatch_get_main_queue(), ^{[sheet show];});
        return sheet;
    }
}

- (id)showAlert:(id<UIAlertViewDelegate>)delegate attributeMsg:(NSAttributedString *)attrStrMsg attributeTitle:(NSAttributedString *)attrStrTitle okButton:(NSString *)strTitleOk okAction:(BlockObject)handleOk cancelButton:(NSString *)strTitleCancel cancelAction:(BlockObject)handleCancel
{
    if (@available(iOS 8.0, *))
    {
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:attrStrTitle.string message:attrStrMsg.string preferredStyle:UIAlertControllerStyleAlert];
//        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:strTitle];
//        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(50, 50, 50) range:NSMakeRange(0, strTitle.length)];
//        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, strTitle.length)];
        [sheet setValue:attrStrTitle forKey:@"attributedTitle"];
//        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:strMsg];
//        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, strMsg.length)];
//        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, strMsg.length)];
        [sheet setValue:attrStrMsg forKey:@"attributedMessage"];
        if (strTitleCancel.length > 0)
        {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:strTitleCancel style:UIAlertActionStyleCancel handler:handleCancel];
            [sheet addAction:cancelAction];
        }
        if (strTitleOk.length > 0)
        {
            UIAlertAction *actionSetting = [UIAlertAction actionWithTitle:strTitleOk style:UIAlertActionStyleDefault handler:handleOk];
            [sheet addAction:actionSetting];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{[self presentViewController:sheet animated:YES completion:nil];});
        return sheet;
    }
    else
    {
        UIAlertView *sheet = [[UIAlertView alloc] initWithTitle:attrStrTitle.string message:attrStrMsg.string delegate:delegate cancelButtonTitle:strTitleCancel otherButtonTitles:strTitleOk, nil];
        dispatch_async(dispatch_get_main_queue(), ^{[sheet show];});
        return sheet;
    }
}

- (id)showAlert:(id<UIAlertViewDelegate>)delegate attributeMsg:(NSAttributedString *)attrStrMsg attributeTitle:(NSAttributedString *)attrStrTitle attributeOkButton:(NSAttributedString *)attrStrTitleOk okAction:(BlockObject)handleOk attributeCancelButton:(NSAttributedString *)attrStrTitleCancel cancelAction:(BlockObject)handleCancel
{
    if (@available(iOS 8.0, *))
    {
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:attrStrTitle.string message:attrStrMsg.string preferredStyle:UIAlertControllerStyleAlert];
        [sheet setValue:attrStrTitle forKey:@"attributedTitle"];
        [sheet setValue:attrStrMsg forKey:@"attributedMessage"];
        if (attrStrTitleCancel.length > 0)
        {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:attrStrTitleCancel.string style:UIAlertActionStyleCancel handler:handleCancel];
            [sheet addAction:cancelAction];
            
            NSRange range = NSMakeRange(0, attrStrTitleCancel.string.length);
            NSDictionary *dic = [attrStrTitleCancel attributesAtIndex:0 effectiveRange:&range];
            UIColor *color = [dic objectForKey:NSForegroundColorAttributeName];
            if (color)
                [cancelAction setValue:color forKey:@"_titleTextColor"];
        }
        if (attrStrTitleOk.length > 0)
        {
            UIAlertAction *actionSetting = [UIAlertAction actionWithTitle:attrStrTitleOk.string style:UIAlertActionStyleDefault handler:handleOk];
            [sheet addAction:actionSetting];
            
            NSRange range = NSMakeRange(0, attrStrTitleCancel.string.length);
            NSDictionary *dic = [attrStrTitleOk attributesAtIndex:0 effectiveRange:&range];
            UIColor *color = [dic objectForKey:NSForegroundColorAttributeName];
            if (color)
                [actionSetting setValue:color forKey:@"_titleTextColor"];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{[self presentViewController:sheet animated:YES completion:nil];});
        return sheet;
    }
    else
    {
        UIAlertView *sheet = [[UIAlertView alloc] initWithTitle:attrStrTitle.string message:attrStrMsg.string delegate:delegate cancelButtonTitle:attrStrTitleCancel.string otherButtonTitles:attrStrTitleOk.string, nil];
        dispatch_async(dispatch_get_main_queue(), ^{[sheet show];});
        return sheet;
    }
}

@end
