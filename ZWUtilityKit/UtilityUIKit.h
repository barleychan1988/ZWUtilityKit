//
//  UtilityKit.h
//  checkCar
//
//  Created by chenzhengwang on 14-5-27.
//  Copyright (c) 2014年 zwchen. All rights reserved.
//

/* ------------------------------------------------------
 *
 * @description：
 *
 * @update time: 2014-12-12
 *
 * ------------------------------------------------------*/

#import <UIKit/UIKit.h>
#import <Foundation/NSObjCRuntime.h>
#import "ZWMacroDef.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define TabBar_HEIGHT 49

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

CGSize getSizeForLabel(NSString *str,UIFont *font, NSLineBreakMode lineBreadMode, CGSize size) NS_AVAILABLE_IOS(7_0);

#pragma mark - Resources

/*
 * @brief: 获取工程下的指定bundle文件包
 * @prama: 
 *      strBundleName：bundle文件包名(不含扩展名),如果为nil，则MainBundle
 * @ret:   对应bundle文件包的NSBundle对象
 */
NSBundle * bundleResource(NSString *strBundleName);

/*
 * @brief: 获取工程下的指定bundle文件包中的指定图片
 * @prama: strBundleName:bundle文件包名(不含扩展名)
 *          strImgName: 图片文件名(含扩展名)
 *          strSubPath:指定图片在bundle中的子目录名称
 * @ret:   指定图片
 *
 * @ex:获取Resources.bundle中images/login/logo.png，
 *      则imageInBundle(@"logo.png",@"Resources", @"images/login");
 */
UIImage * imageInBundle(NSString *strImgName, NSString *strBundleName, NSString *strSubPath);
/*
 * @brief: 功能同imageInBundle，采用缓存机制
 */
UIImage * imageNamed(NSString *strImgName, NSString *strBundleName, NSString *strSubPath);

/*
 *
 */
UIView * nibInBundle(NSString *strNibName, NSString *strBundleName, NSString *strSubPath, id owner);

//获取应用程序的window
UIWindow *getApplicationWindow();

//移除viewParent上所有subview
void removeAllSubviews(UIView *viewParent);

//取消第一响应者
void cancelFirstRespond();
/*
 *  @brief：查找view子窗口及嵌套子窗口中的第一响应者
 *  @ret：第一响应者，若无则返回nil
 */
UIView *findFirstResponderBeneathView(UIView* view);

/*
 *  @brief: 播放wav音频文件
 */
void playBeep(NSString *strFileName);


#pragma mark - alert

void showAlertMsg(id<UIAlertViewDelegate> vc, NSString *strMsg, NSString *strTitle, NSString *strBtnTitle1, NSString *strBtnTitle2, BlockVoid handleDefault, BlockVoid handleCancel);
