//
//  ZWNetImageView.h
//  Test
//
//  Created by chenzw on 15/8/8.
//  Copyright (c) 2015年 BiggerSister. All rights reserved.
//
/*
 *  @brief: 加载网络图片显示控件
 *
 */
#import <UIKit/UIKit.h>
#import "ZWIndicatorView.h"

@interface ZWNetImageView : UIView

@property (nonatomic, retain)ZWIndicatorView *activityView;

@property (nonatomic, retain)NSString *strUrl;//图片网络地址

- (void)startDownLoad;

@end