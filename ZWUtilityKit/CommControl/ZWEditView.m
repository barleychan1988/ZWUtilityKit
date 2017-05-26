//
//  UIEditView.m
//  Test
//
//  Created by chenzw on 15/6/15.
//  Copyright (c) 2015年 BiggerSister. All rights reserved.
//

#import "ZWEditView.h"
#import "Geometry+ZWExtension.h"

#pragma mark -

@interface ZWEditView()
{
    UIButton *m_btnClose;
    UIButton *m_btnRotate;//旋转、缩放按钮
    CGRect initialBounds;
    CGFloat initialDistance;
    CGFloat deltaAngle;
    
    UIPanGestureRecognizer *m_panGestureMove;//移动位置手势
    UITapGestureRecognizer *m_tapGestureSelecte;//选中手势
    
    BOOL m_bEditing;    //选中状态
    
    CGFloat m_fSysBtnRadius;//关闭或拉伸按钮半径 default is 8.0.  受imageCloseBtn、imageRotateBtn改变
}
@end

@implementation ZWEditView

- (id)initWithFrame:(CGRect)frame
{
    if (CGRectEqualToRect(frame, CGRectZero))
    {
        frame = CGRectMake(0, 0, 32, 32);
    }
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        m_fScale = 1.0;
        _sizeMinContentView = CGSizeZero;
        _colorSelectedFrame = [UIColor redColor];
        _fWidthSelectedFrame = 1.0;
        _bDashLine = YES;
        m_fSysBtnRadius = 8.0;
        
        self.bCanEdit = YES;
        
        self.bCanClose = YES;
        self.bCanRotateScale = YES;
        self.bCanMove = YES;
        
        _bBringToFrontWhenSelected = YES;
    }
    return self;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
}

- (void)drawRect:(CGRect)rect
{
    if (m_bEditing)//画边
    {
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectInset(self.bounds, m_fSysBtnRadius, m_fSysBtnRadius)];
        CGContextRef context = UIGraphicsGetCurrentContext();
        [_colorSelectedFrame set];
        if (_bDashLine)
        {
            CGFloat dashPattern[2] = {4, 3};
            CGContextSetLineDash(context, 0, dashPattern, 2);
        }
        CGContextAddPath(context, path.CGPath);
        CGContextSetLineWidth(context, _fWidthSelectedFrame);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextDrawPath(context, kCGPathStroke);
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *viewHit = [super hitTest:point withEvent:event];
    if (viewHit == self)
    {
        CGRect bounds = CGRectInset(self.bounds, m_fSysBtnRadius, m_fSysBtnRadius);
        if (!CGRectContainsPoint(bounds, point))
        {
            viewHit = nil;
        }
    }
    if (m_bEditing && _bIsCloseToBorder && viewHit == self.contentView)
    {
        if (CGRectContainsPoint(m_btnClose.frame, point))
        {
            return m_btnClose;
        }
        else if (CGRectContainsPoint(m_btnRotate.frame, point))
        {
            return m_btnRotate;
        }
    }
    return viewHit;
}

- (BOOL)canBecomeFirstResponder
{
    return _bCanEdit;
}

- (BOOL)becomeFirstResponder
{
    id keyWindow = [[UIApplication sharedApplication] keyWindow];
    SEL selector = NSSelectorFromString(@"firstResponder");
    UIView *firstResponder = nil;
    if ([keyWindow respondsToSelector:selector])
    {
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
        firstResponder = [keyWindow performSelector:selector];
        _Pragma("clang diagnostic pop")
    }
    if (firstResponder == self)
        return YES;
    [firstResponder resignFirstResponder];
    BOOL bRet = [super becomeFirstResponder];
    [self setSelected:bRet];    
    return bRet;
}

- (BOOL)resignFirstResponder
{
    BOOL bRet = [super resignFirstResponder];
    [self setSelected:!bRet];
    return bRet;
}

#pragma mark - propert

- (void)setImageCloseBtn:(UIImage *)imageCloseBtn
{
    if (imageCloseBtn == nil)
    {
        m_btnClose.layer.cornerRadius = m_btnClose.bounds.size.width / 2;
        m_btnClose.backgroundColor = [UIColor redColor];
        return;
    }
    m_btnClose.layer.cornerRadius = 0.0;
    m_btnClose.backgroundColor = nil;
    _imageCloseBtn = imageCloseBtn;
    [m_btnClose setImage:imageCloseBtn forState:UIControlStateNormal];
    
    //计算
    CGFloat nOffset = _imageCloseBtn.size.width > _imageCloseBtn.size.height ? _imageCloseBtn.size.width : _imageCloseBtn.size.height;
    nOffset /= 2.0;
    if (nOffset > m_fSysBtnRadius)
    {
        UIViewAutoresizing oldMask = _contentView.autoresizingMask;
        _contentView.autoresizingMask = UIViewAutoresizingNone;
        CGFloat fDiff = (m_fSysBtnRadius - nOffset);
        
        if (_bIsCloseToBorder)
        {
            self.frame = CGRectInset(self.frame, fDiff, fDiff);
            _contentView.frame = CGRectInset(self.bounds, nOffset, nOffset);
        }
        else
        {
            fDiff *= 2.0;
            self.frame = CGRectInset(self.frame, fDiff, fDiff);
            _contentView.frame = CGRectInset(self.bounds, nOffset + nOffset, nOffset + nOffset);
        }
        
        _contentView.autoresizingMask = oldMask;
        m_fSysBtnRadius = nOffset;
        m_btnClose.frame = CGRectMake(m_btnClose.frame.origin.x, m_btnClose.frame.origin.y, m_fSysBtnRadius * 2, m_fSysBtnRadius * 2);
        m_btnRotate.frame = CGRectMake(m_btnRotate.frame.origin.x + fDiff * 2, m_btnRotate.frame.origin.y + fDiff * 2, m_fSysBtnRadius * 2, m_fSysBtnRadius * 2);
        if (_imageRotateBtn == nil)
        {
            m_btnRotate.layer.cornerRadius = m_fSysBtnRadius;
        }
    }
}

- (void)setImageRotateBtn:(UIImage *)imageRotateBtn
{
    if (imageRotateBtn == nil)
    {
        m_btnRotate.layer.cornerRadius = m_btnRotate.bounds.size.width / 2;
        m_btnRotate.backgroundColor = [UIColor colorWithRed:78.0/255 green:1 blue:254.0/255 alpha:1];
        return;
    }
    m_btnRotate.layer.cornerRadius = 0.0;
    m_btnRotate.backgroundColor = nil;
    
    _imageRotateBtn = imageRotateBtn;
    [m_btnRotate setImage:imageRotateBtn forState:UIControlStateNormal];
    
    //计算
    CGFloat nOffset = _imageRotateBtn.size.width > _imageRotateBtn.size.height ? _imageRotateBtn.size.width : _imageRotateBtn.size.height;
    nOffset /= 2.0;
    if (nOffset > m_fSysBtnRadius)
    {
        UIViewAutoresizing oldMask = _contentView.autoresizingMask;
        _contentView.autoresizingMask = UIViewAutoresizingNone;
        CGFloat fDiff = (m_fSysBtnRadius - nOffset);
        
        if (_bIsCloseToBorder)
        {
            self.frame = CGRectInset(self.frame, fDiff, fDiff);
            _contentView.frame = CGRectInset(self.bounds, nOffset, nOffset);
        }
        else
        {
            fDiff *= 2;
            self.frame = CGRectInset(self.frame, fDiff, fDiff);
            _contentView.frame = CGRectInset(self.bounds, nOffset + nOffset, nOffset + nOffset);
        }
        
        _contentView.autoresizingMask = oldMask;
        m_fSysBtnRadius = nOffset;
        m_btnClose.frame = CGRectMake(m_btnClose.frame.origin.x, m_btnClose.frame.origin.y, m_fSysBtnRadius * 2, m_fSysBtnRadius * 2);
        m_btnRotate.frame = CGRectMake(m_btnRotate.frame.origin.x + fDiff, m_btnRotate.frame.origin.y + fDiff, m_fSysBtnRadius * 2, m_fSysBtnRadius * 2);
        if (_imageCloseBtn == nil)
        {
            m_btnClose.layer.cornerRadius = m_fSysBtnRadius;
        }
    }
}

/*
 *  @brief:是否关闭窗口，若不可以则删除伸缩按钮
 */
- (void)setBCanRotateScale:(BOOL)bCanRotateScale
{
    if (_bCanRotateScale == bCanRotateScale)
        return;
    
    _bCanRotateScale = bCanRotateScale;
    if (_bCanRotateScale)
    {
        if (m_btnRotate == nil)
        {
            m_btnRotate = [UIButton buttonWithType:UIButtonTypeCustom];
            m_btnRotate.frame = CGRectMake(self.bounds.size.width - m_fSysBtnRadius * 2, self.bounds.size.height - m_fSysBtnRadius * 2, m_fSysBtnRadius * 2, m_fSysBtnRadius * 2);
            m_btnRotate.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
            m_btnRotate.layer.cornerRadius = m_btnRotate.bounds.size.width / 2;
            m_btnRotate.backgroundColor = [UIColor colorWithRed:78.0/255 green:1 blue:254.0/255 alpha:1];
            UIPanGestureRecognizer *panRotateGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotateViewPanGesture:)];
            [m_btnRotate addGestureRecognizer:panRotateGesture];
        }
        [self addSubview:m_btnRotate];
        m_btnRotate.hidden = !m_bEditing;
    }
    else
    {
        [m_btnRotate removeFromSuperview];
        m_btnRotate = nil;
    }
}
/*
 *  @brief:是否关闭窗口，若不可以则删除关闭按钮
 */
- (void)setBCanClose:(BOOL)bCanClose
{
    if (_bCanClose == bCanClose)
        return;
    _bCanClose = bCanClose;
    if (_bCanClose)
    {
        if (m_btnClose == nil)
        {
            m_btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
            m_btnClose.frame = CGRectMake(0, 0, m_fSysBtnRadius * 2, m_fSysBtnRadius * 2);
            m_btnClose.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
            m_btnClose.layer.cornerRadius = m_btnClose.bounds.size.width / 2;
            m_btnClose.backgroundColor = [UIColor redColor];
            [m_btnClose addTarget:self action:@selector(btnClickedClose:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:m_btnClose];
        m_btnClose.hidden = !m_bEditing;
    }
    else
    {
        [m_btnClose removeFromSuperview];
        m_btnClose = nil;
    }
}
/*
 *  @brief:是否可以移动窗口，若不可以则删除移动手势
 */
- (void)setBCanMove:(BOOL)bCanMove
{
    if (_bCanMove == bCanMove)
        return;
    _bCanMove = bCanMove;
    if (_bCanMove)
    {
        if (m_panGestureMove == nil)
        {
            UIPanGestureRecognizer *moveGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveGesture:)];
            moveGesture.maximumNumberOfTouches = 1;
            m_panGestureMove = moveGesture;
        }
        if (m_bEditing)
        {
            [self addGestureRecognizer:m_panGestureMove];
        }
    }
    else
    {
        [m_panGestureMove.view removeGestureRecognizer:m_panGestureMove];
        m_panGestureMove = nil;
    }
}

- (void)setBCanEdit:(BOOL)bCanEdit
{
    if (_bCanEdit == bCanEdit)
        return;
    
    _bCanEdit = bCanEdit;
    if (_bCanEdit)
    {
        if (m_tapGestureSelecte == nil)
        {
            m_tapGestureSelecte = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRespons:)];
            m_tapGestureSelecte.numberOfTapsRequired = 1;
        }
        [self addGestureRecognizer:m_tapGestureSelecte];
    }
    else
    {
        [self removeGestureRecognizer:m_tapGestureSelecte];
    }
    self.contentView.userInteractionEnabled = _bCanEdit;
    self.userInteractionEnabled = _bCanEdit;
}

@synthesize fScale = m_fScale;

- (void)setContentView:(UIView *)contentView
{
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    if (self.bounds.size.width > m_fSysBtnRadius * 4 && self.bounds.size.height > m_fSysBtnRadius * 4)
    {
        _contentView.frame = CGRectInset(self.bounds, m_fSysBtnRadius, m_fSysBtnRadius);
    }
    else
    {
        CGRect frame = self.frame;
        frame.size.width = _contentView.frame.size.width + m_fSysBtnRadius * 4;
        frame.size.height = _contentView.frame.size.height + m_fSysBtnRadius * 4;
        self.frame = frame;
        
        frame = _contentView.frame;
        frame.origin.x = (self.bounds.size.width - frame.size.width) / 2;
        frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
        _contentView.frame = frame;
    }
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_contentView];
    [self bringSubviewToFront:m_btnClose];
    [self bringSubviewToFront:m_btnRotate];
}

#pragma mark - inner method

- (void)setSelected:(BOOL)bSelected
{
    if (!_bCanEdit || bSelected == m_bEditing)
        return;
    m_bEditing = bSelected;
    if (bSelected)
    {
        m_btnClose.hidden = NO;
        m_btnRotate.hidden = NO;
        if (m_panGestureMove)
            [self addGestureRecognizer:m_panGestureMove];
    }
    else
    {
        m_btnClose.hidden = YES;
        m_btnRotate.hidden = YES;        
        [m_panGestureMove.view removeGestureRecognizer:m_panGestureMove];
    }
    [self setNeedsDisplay];
}

/*
 *  @brief：获取缩小时最小的size，下于此size时不可在缩小
 */
- (CGSize)mininumSizeScale
{
    CGSize sizeRet = CGSizeZero;
    if (_bIsCloseToBorder)
    {
        sizeRet.width = m_fSysBtnRadius * 2;
        sizeRet.height = m_fSysBtnRadius * 2;
    }
    else
    {
        sizeRet.width = m_fSysBtnRadius * 4;
        sizeRet.height = m_fSysBtnRadius * 4;
    }
    return sizeRet;
}

#pragma mark - method

- (void)setContentFrame:(CGRect)frame
{
    if (_bIsCloseToBorder)
    {
        self.frame = CGRectInset(frame, -m_fSysBtnRadius, -m_fSysBtnRadius);
        _contentView.frame = CGRectMake(m_fSysBtnRadius, m_fSysBtnRadius, frame.size.width, frame.size.height);
    }
    else
    {
        self.frame = CGRectInset(frame, -m_fSysBtnRadius * 2, -m_fSysBtnRadius * 2);
        _contentView.frame = CGRectMake(m_fSysBtnRadius * 2, m_fSysBtnRadius * 2, frame.size.width, frame.size.height);
    }
}

#pragma mark -

- (IBAction)btnClickedClose:(id)sender
{
    BOOL bCanRemoved = YES;
    if ([_delegate respondsToSelector:@selector(editViewWillRemoved:)])
    {
        bCanRemoved = [_delegate editViewWillRemoved:self];
    }
    if (bCanRemoved)
    {
        if ([_delegate respondsToSelector:@selector(editViewDidRemoved:)])
        {
            [_delegate editViewDidRemoved:self];
        }
        [self removeFromSuperview];
    }
}

- (void)tapGestureRespons:(UITapGestureRecognizer *)tapGesture
{
    if ([_delegate respondsToSelector:@selector(editViewWillSelected:)])
    {
        if (![_delegate editViewWillSelected:self])
        {
            return;
        }
    }
    [self becomeFirstResponder];
    if (_bBringToFrontWhenSelected)
    {
        [self.superview bringSubviewToFront:self];
    }
    if ([_delegate respondsToSelector:@selector(editViewDidSelected:)])
    {
        [_delegate editViewDidSelected:self];
    }
}

- (void)moveGesture:(UIPanGestureRecognizer *)panGesture
{    
    if ([_delegate respondsToSelector:@selector(editViewWillSelected:)])
    {
        if (![_delegate editViewWillSelected:self])
        {
            return;
        }
    }
    if (!m_bEditing)
    {
        return;
    }
    if ([panGesture state] == UIGestureRecognizerStateBegan)
    {
        if (_bBringToFrontWhenSelected)
        {
            [self.superview bringSubviewToFront:self];
        }
    }
    
    CGPoint translation = [panGesture translationInView:self.superview];
    CGPoint ptCenter = self.center;
    ptCenter.x += translation.x;
    ptCenter.y += translation.y;
    /*边界限制
    //线条部分不能超出画板
    UIView *view = panGesture.view;
    CGRect frame = panGesture.view.frame;
    frame.origin.x += translation.x;
    frame.origin.y += translation.y;
     if (frame.origin.x + view.fBrushMaxWidth / 2 < 0)
     ptCenter.x -= (frame.origin.x + view.fBrushMaxWidth / 2);
     if (frame.origin.y + view.fBrushMaxWidth / 2 < 0)
     ptCenter.y -= (frame.origin.y + view.fBrushMaxWidth / 2);
     if (frame.origin.x + frame.size.width - view.fBrushMaxWidth / 2 > viewSuper.bounds.size.width)
     ptCenter.x -= (frame.size.width - view.fBrushMaxWidth / 2 + frame.origin.x - viewSuper.bounds.size.width);
     if (frame.origin.y + frame.size.height - view.fBrushMaxWidth / 2 > viewSuper.bounds.size.height)
     ptCenter.y -= (frame.origin.y + frame.size.height - view.fBrushMaxWidth / 2 - viewSuper.bounds.size.height);
     */
    self.center = ptCenter;
    [panGesture setTranslation:CGPointZero inView:self.superview];
//    [[self contentView] setNeedsDisplay];
}

- (void)rotateViewPanGesture:(UIPanGestureRecognizer *)panGesture
{
    CGPoint touchLocation = [panGesture locationInView:self.superview];
    
    CGPoint center = self.center;
    
    if ([panGesture state] == UIGestureRecognizerStateBegan)
    {
        if (_bBringToFrontWhenSelected)
        {
            [self.superview bringSubviewToFront:self];
        }
        if (m_fScale == 1)
        {
            //拉伸变量初始化
            deltaAngle = atan2(touchLocation.y-center.y, touchLocation.x-center.x)- atan2(self.transform.b, self.transform.a);

            initialBounds = self.bounds;
            initialDistance = CGPointGetDistance(center, touchLocation);
        }
//
//        if([_delegate respondsToSelector:@selector(labelViewDidBeginEditing:)])
//        {
//            [_delegate labelViewDidBeginEditing:self];
//        }
    }
    else if ([panGesture state] == UIGestureRecognizerStateChanged)
    {
        float ang = atan2(touchLocation.y-center.y, touchLocation.x-center.x);
        float angleDiff = deltaAngle - ang;
        [self setTransform:CGAffineTransformMakeRotation(-angleDiff)];

        //Finding scale between current touchPoint and previous touchPoint
        double scale = CGPointGetDistance(center, touchLocation) / initialDistance;
        m_fScale = scale;

        CGRect scaleRect = CGRectScale(initialBounds, scale, scale);
        
        CGSize szMini = [self mininumSizeScale];
        if (scaleRect.size.width > szMini.width && scaleRect.size.height > szMini.height)
        {
//            if (_fontSize < 100 || CGRectGetWidth(scaleRect) < CGRectGetWidth(self.bounds))
            {
//                [_textView adjustsFontSizeToFillRect:scaleRect];
                [self setBounds:scaleRect];
            }
        }
//        if([_delegate respondsToSelector:@selector(labelViewDidChangeEditing:)])
//        {
//            [_delegate labelViewDidChangeEditing:self];
//        }
        [self setNeedsDisplay];
//        [[self contentView] setNeedsDisplay];
    }
    else if ([panGesture state] == UIGestureRecognizerStateEnded)
    {
//        if([_delegate respondsToSelector:@selector(labelViewDidEndEditing:)])
//        {
//            [_delegate labelViewDidEndEditing:self];
//        }
    }
}
/*
CGPoint g_pointBegin;
CGSize g_sizeOffset;
CGRect g_rectOrigin;

- (IBAction)btnBeginZoomView:(id)sender withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
    g_rectOrigin = self.frame;
    g_pointBegin = location;
}

- (IBAction)btnZoomView:(id)sender withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
    g_sizeOffset.width = location.x - g_pointBegin.x;
    g_sizeOffset.height = location.y - g_pointBegin.y;
    self.frame = CGRectInset(g_rectOrigin, -g_sizeOffset.width, -g_sizeOffset.height);
    NSLog(@"x=%.2f,y=%.2f,width=%.2f,height=%.2f", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (IBAction)btnEndZoomView:(id)sender withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
}
 */
@end
