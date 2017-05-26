//
//  ZWStartEvaluateIntView.h
//  ZWUtilityKit
//
//  Created by chenzw on 15/9/10.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

/* ------------------------------------------------------
 *
 * @description：五星等级评价
 *      评分时只能整数的评，但可以显示小数的评分
 *
 * @update time: 2015-05-05
 *
 * ------------------------------------------------------*/

#import <UIKit/UIKit.h>

@interface ZWStartEvaluateIntView : UIView

@property (nonatomic, assign)BOOL bCanEvaluate;    //是否可以评分,default is NO.

@property (nonatomic, assign)float fMaxScore; //default is 100. fMaxScore is must bigger than fMinScore.
@property (nonatomic, assign)float fMinScore; //default is 0.
@property (nonatomic, assign)float fScore;

@property (nonatomic, retain)UIImage *imageDisable;
@property (nonatomic, retain)UIImage *imageEnable;
@property (nonatomic, assign)NSInteger nStartNum; //default is 5. 必须在设置image前设置值

@end