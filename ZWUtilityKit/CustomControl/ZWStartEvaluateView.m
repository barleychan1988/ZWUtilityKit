//
//  ZWStartEvaluation.m
//  ZWUtilityKit
//
//  Created by chenzw on 15/5/5.
//  Copyright (c) 2015年 zwchen. All rights reserved.
//

#import "ZWStartEvaluateView.h"

@interface ZWStartEvaluateView()
{
    UIImage *m_imageFullStart;
    UIImageView *m_imageViewFullStart;//满五星imageView
    UIImageView *m_imageViewEmptyStart;//空五星imageView
    
//    float m_fScore;//实时记录评价详细分数
}
@end

@implementation ZWStartEvaluateView

#pragma mark - synthesize

- (void)setBCanEvaluate:(BOOL)bCanEvaluate
{
    _bCanEvaluate = bCanEvaluate;
    if (_bCanEvaluate)
    {
        m_imageViewEmptyStart.userInteractionEnabled = YES;
        //单击手势
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStart:)];
        [m_imageViewEmptyStart addGestureRecognizer:tapGR];
        //拖动手势
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panStart:)];
        [m_imageViewEmptyStart addGestureRecognizer:panGR];
    }
    else
    {
        for (UIGestureRecognizer *gesture in m_imageViewFullStart.gestureRecognizers)
        {
            [m_imageViewFullStart removeGestureRecognizer:gesture];
        }
        for (UIGestureRecognizer *gesture in m_imageViewEmptyStart.gestureRecognizers)
        {
            [m_imageViewEmptyStart removeGestureRecognizer:gesture];
        }
    }
}

- (void)setFScore:(float)fScore
{
    _fScore = fScore;
    [self layoutSubviews];
}

#pragma mark - init

- (id)init
{
    if (self = [super init])
    {
        [self initSubviews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    _fMaxScore = 100;
    _fMinScore = 0;
    _fScore = _fMinScore;
    
    UIImage *image = [UIImage imageNamed:@"ZWStartEvaluateView.bundle/EmptyStart"];
    m_imageViewEmptyStart = [[UIImageView alloc] initWithImage:image];
    m_imageViewEmptyStart.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [self addSubview:m_imageViewEmptyStart];
    
    m_imageFullStart = [UIImage imageNamed:@"ZWStartEvaluateView.bundle/FullStart"];
    m_imageViewFullStart = [[UIImageView alloc] initWithImage:m_imageFullStart];
    m_imageViewFullStart.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    m_imageViewFullStart.contentMode = UIViewContentModeLeft;
    m_imageViewFullStart.clipsToBounds = YES;
    [self addSubview:m_imageViewFullStart];
}

- (void)layoutSubviews
{
    CGRect frame = CGRectMake(0, 0, m_imageFullStart.size.width, m_imageFullStart.size.height);
    if (self.bounds.size.height > frame.size.height && self.bounds.size.width > frame.size.width)
    {
        frame.origin.x = (self.bounds.size.width - frame.size.width ) / 2;
        frame.origin.y = (self.bounds.size.height - frame.size.height ) / 2;
    }
    else if (self.bounds.size.width > frame.size.width)
    {
        CGFloat nRate = self.bounds.size.height / frame.size.height;
        frame.size.width *= nRate;
        frame.size.width = floor(frame.size.width);
        frame.origin.x = (self.bounds.size.width - frame.size.width) / 2;
        frame.size.height = self.bounds.size.height;
    }
    else if (self.bounds.size.height > frame.size.height)
    {
        CGFloat nRate = self.bounds.size.width / frame.size.width;
        frame.size.height *= nRate;
        frame.size.height = floor(frame.size.height);
        frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
        frame.size.width = self.bounds.size.width;
    }
    else
    {
        CGFloat nRateWidth = self.bounds.size.width / frame.size.width;
        CGFloat nRateHeight = self.bounds.size.height / frame.size.height;
        if (nRateHeight < nRateWidth)
        {
            frame.size.height = self.bounds.size.height;
            frame.size.width *= nRateHeight;
        }
        else
        {
            frame.size.width = self.bounds.size.width;
            frame.size.height *= nRateWidth;
        }
        frame.size.width = floor(frame.size.width);
        frame.size.height = floor(frame.size.height);
        frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
        frame.origin.x = (self.bounds.size.width - frame.size.width) / 2;
    }
    m_imageViewEmptyStart.frame = frame;
    frame.size.width *= (_fScore / (_fMaxScore - _fMinScore));
    m_imageViewFullStart.frame = frame;
    
    UIGraphicsBeginImageContext(m_imageViewEmptyStart.frame.size);
    [m_imageFullStart drawInRect:m_imageViewEmptyStart.bounds];
    m_imageViewFullStart.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

#pragma mark 手势
//单击手势
-(void)tapStart:(UITapGestureRecognizer *)tapGR
{
    CGPoint pointTap = [tapGR locationInView:m_imageViewEmptyStart];
    _fScore = pointTap.x / m_imageViewEmptyStart.bounds.size.width * (_fMaxScore - _fMinScore);
    
    [self layoutSubviews];
    
    if (_delegate)
    {
        [_delegate startEvaluate:self didChangeValue:_fScore];
    }
}

//拖动手势
- (void)panStart:(UIPanGestureRecognizer *)panGR
{
    CGPoint pointPan = [panGR locationInView:m_imageViewEmptyStart];
    if (pointPan.x < 0 || pointPan.x > m_imageViewEmptyStart.bounds.size.width)
    {
        return;
    }    
    _fScore = pointPan.x / m_imageViewEmptyStart.bounds.size.width * (_fMaxScore - _fMinScore);
    [self layoutSubviews];
    
    if (_delegate)
    {
        [_delegate startEvaluate:self didChangeValue:_fScore];
    }
}

@end