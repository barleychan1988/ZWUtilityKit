//
//  ZWStartEvaluation.h
//  ZWUtilityKit
//
//  Created by chenzw on 15/5/5.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//
/* ------------------------------------------------------
 *
 * @description：五星等级评价
 *      ZWStartEvaluation.bundle中资源图片空星和满星大小是一样的，
 *    且星星的位置也要一致
 *
 * @update time: 2015-05-05
 *
 * ------------------------------------------------------*/

#import <UIKit/UIKit.h>

@protocol ZWStartEvaluateDelegate;


@interface ZWStartEvaluateView : UIView

@property (nonatomic,assign) id<ZWStartEvaluateDelegate> delegate;

@property (nonatomic, assign)BOOL bCanEvaluate;    //是否可以评分,default is NO.

@property (nonatomic, assign)float fMaxScore; //default is 100. fMaxScore is must bigger than fMinScore.
@property (nonatomic, assign)float fMinScore; //default is 0.
@property (nonatomic, assign)float fScore;

@end


@protocol ZWStartEvaluateDelegate <NSObject>

@required
- (void)startEvaluate:(ZWStartEvaluateView *)startEvaluateView didChangeValue:(CGFloat)fScore;

@end