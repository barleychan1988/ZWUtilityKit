//
//  ZWIndicatorView.h
//  checkCar
//
//  Created by chenzhengwang on 14-7-5.
//  Copyright (c) 2014年 zwchen. All rights reserved.
//

/* ------------------------------------------------------
 *
 * @description：该View是用于加载时显示的加载等待提示指示器
 *              加载时显示等待指示器，加载失败后显示提示文字，失败后可以点击重新加载
 *              缺省是显示加载动画
 *              加载失败点击重新加载时需实现ZWIndicatorProtocol协议
 *
 * @update time: 2014-07-05
 *
 * ------------------------------------------------------*/

#import <UIKit/UIKit.h>
#import "TFIndicatorView.h"

@protocol ZWIndicatorProtocol;

@interface ZWIndicatorView : UIControl

@property (nonatomic, assign)id<ZWIndicatorProtocol> delegate;

@property (nonatomic,assign) NSUInteger numOfObjects;
@property (nonatomic,assign) CGSize objectSize;
@property (nonatomic,retain) UIColor *color;    //旋转的小方块颜色


-(void)startAnimating;
-(void)stopAnimating;

@property (nonatomic, copy) NSString *strTipTitle;

@end



#pragma mark - ZWIndicatorProtocol

@protocol ZWIndicatorProtocol <NSObject>

@required
/*
 *  @brief:加载失败后，点击重新加载执行方法
 */
- (void)reloadRequest;

@optional

@end