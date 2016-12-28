//
//  SeperatorLIneView.m
//  NavTip
//
//  Created by EadkennyChan on 16/7/2.
//  Copyright © 2016年 EadkennyChan. All rights reserved.
//

#import "UIView+AddLine.h"

#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

typedef NS_ENUM(NSInteger, GridLineType)
{
    GridLineType_Other = 0,
    GridLineType_Top,
    GridLineType_Right,
    GridLineType_Bottom,
    GridLineType_Left
};

@interface SeperatorLineView : UIView

/**
 * @brief 网格线宽度，默认为1 pixel (1.0f / [UIScreen mainScreen].scale)
 */
@property (nonatomic, assign)CGFloat fWidthLine;
/**
 * @brief 缩进
 */
@property (nonatomic, assign)CGFloat fIndent;
/**
 * @brief 网格颜色，默认grayColor
 */
@property (nonatomic, strong)UIColor *colorLine;

@property (nonatomic, assign)GridLineType typeLine;

@end

@implementation SeperatorLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame color:[UIColor grayColor] width:SINGLE_LINE_WIDTH];
}

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    return [self initWithFrame:frame color:color width:SINGLE_LINE_WIDTH];
}

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color width:(CGFloat)width
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        _colorLine = color;
        _fWidthLine = width;
        _fIndent = 0;
    }
    return self;
}

- (void)setColorLine:(UIColor *)colorLine
{
    _colorLine = colorLine;
    [self setNeedsDisplay];
}

- (void)setFWidthLine:(CGFloat)fWidthLine
{
    _fWidthLine = fWidthLine;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    /**
     *  https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
     * 仅当要绘制的线宽为奇数像素时，绘制位置需要调整
     */
    CGFloat pixelAdjustOffset = 0;
    if (((int)(_fWidthLine * [UIScreen mainScreen].scale) + 1) % 2 == 0)
    {
        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
    }
    CGFloat xStart = 0;
    CGFloat yStart = 0;
    CGFloat xEnd = 0;
    CGFloat yEnd = 0;
    switch (_typeLine)
    {
        case GridLineType_Top:
        {
            yStart = SINGLE_LINE_WIDTH;
            xStart =  _fIndent;
            xEnd = self.frame.size.width;
            yEnd = yStart;
        }
            break;
        case GridLineType_Right:
            xStart = self.frame.size.width - SINGLE_LINE_WIDTH;
            yStart =  _fIndent;
            xEnd = xStart;
            yEnd = self.frame.size.height;
            break;
        case GridLineType_Bottom:
        {
            xStart =  _fIndent;
            yStart = self.frame.size.height;
            CGFloat fPointValue = (yStart - (int)yStart) * 2;
            while (fPointValue >= SINGLE_LINE_WIDTH)
            {
                fPointValue -= SINGLE_LINE_WIDTH;
            }
            yStart -= fPointValue;
            xEnd = self.frame.size.width;
            yEnd = yStart;
        }
            break;
        case GridLineType_Left:
            xStart =  0;
            yStart =  _fIndent;
            xEnd =  xStart;
            yEnd = self.frame.size.height;
            break;
        default:
            xStart =  SINGLE_LINE_WIDTH;
            yStart =  SINGLE_LINE_WIDTH;
            xEnd =  SINGLE_LINE_WIDTH;
            yEnd =  SINGLE_LINE_WIDTH;
            break;
    }
    CGContextMoveToPoint(context, xStart, yStart);
    CGContextAddLineToPoint(context, xEnd, yEnd);
    /*
    while (yPos < self.bounds.size.height) {
        CGContextMoveToPoint(context, 0, yPos);
        CGContextAddLineToPoint(context, self.bounds.size.width, yPos);
        yPos += lineMargin;
    }*/
    CGContextSetShouldAntialias(context, NO);
    CGContextSetLineWidth(context, _fWidthLine);
    CGContextSetStrokeColorWithColor(context, _colorLine.CGColor);
    CGContextStrokePath(context);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frameSelf = [self.superview convertRect:self.superview.bounds toView:nil];
    CGFloat fPointValueY = (frameSelf.origin.y - (int)(frameSelf.origin.y));
    while (fPointValueY >= SINGLE_LINE_WIDTH)
    {
        fPointValueY -= SINGLE_LINE_WIDTH;
    }
    CGFloat fPointValueX = (frameSelf.origin.x - (int)(frameSelf.origin.x));
    while (fPointValueX >= SINGLE_LINE_WIDTH)
    {
        fPointValueX -= SINGLE_LINE_WIDTH;
    }
    frameSelf = self.superview.bounds;
    frameSelf.origin.y = - fPointValueY;
    frameSelf.origin.x = - fPointValueX;
    frameSelf.size.height = self.superview.bounds.size.height - frameSelf.origin.y;
    fPointValueY = (frameSelf.size.height - (int)(frameSelf.size.height));
    while (fPointValueY >= SINGLE_LINE_WIDTH)
    {
        fPointValueY -= SINGLE_LINE_WIDTH;
    }
    frameSelf.size.height += (SINGLE_LINE_WIDTH - fPointValueY);
    frameSelf.size.width = self.superview.bounds.size.width - frameSelf.origin.x;
    fPointValueX = (frameSelf.size.width - (int)(frameSelf.size.width));
    while (fPointValueX >= SINGLE_LINE_WIDTH)
    {
        fPointValueX -= SINGLE_LINE_WIDTH;
    }
    frameSelf.size.width += (SINGLE_LINE_WIDTH - fPointValueX);
    self.frame = frameSelf;
    [self setNeedsDisplay];
}

@end

#pragma mark -
//
//  UIView+AddLine.m
//  ZWMultiTbv
//
//  Created by chenzhengwang on 13-12-6.
//  Copyright (c) 2013年 zwchen. All rights reserved.
//

@implementation UIView(AddLine)

- (UIView *)addTopUnitPixLine:(UIColor *)color
{
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:self.bounds color:color];
    view.typeLine = GridLineType_Top;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    return view;
}

- (UIView *)addTopUnitPixLine:(UIColor *)color indent:(CGFloat)fIndent
{
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:self.bounds color:color];
    view.typeLine = GridLineType_Top;
    view.fIndent = fIndent;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    return view;
}

- (UIView *)addBottomUnitPixLine:(UIColor *)color
{
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:self.bounds color:color];
    view.typeLine = GridLineType_Bottom;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    return view;
}

- (UIView *)addBottomUnitPixLine:(UIColor *)color indent:(CGFloat)fIndent
{
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:self.bounds color:color];
    view.typeLine = GridLineType_Bottom;
    view.fIndent = fIndent;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    return view;
}

- (UIView *)addLeftUnitPixLine:(UIColor *)color
{
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:self.bounds color:color];
    view.typeLine = GridLineType_Left;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    return view;
}

- (UIView *)addLeftUnitPixLine:(UIColor *)color indent:(CGFloat)fIndent
{
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:self.bounds color:color];
    view.typeLine = GridLineType_Left;
    view.fIndent = fIndent;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    return view;
}

- (UIView *)addRightUnitPixLine:(UIColor *)color
{
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:self.bounds color:color];
    view.typeLine = GridLineType_Right;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    return view;
}

- (UIView *)addRightUnitPixLine:(UIColor *)color indent:(CGFloat)fIndent
{
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:self.bounds color:color];
    view.typeLine = GridLineType_Right;
    view.fIndent = fIndent;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    return view;
}

- (UIView *)addTopLineWithWidth:(CGFloat)width color:(UIColor *)color
{
    UIView *viewTopLine = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, width)];
    
    viewTopLine.backgroundColor = color;
    viewTopLine.autoresizingMask = UIViewAutoresizingFlexibleWidth/* | UIViewAutoresizingFlexibleTopMargin*/;
    
    [self addSubview:viewTopLine];
    return viewTopLine;
}

- (UIView *)addTopUnitPixLine2:(UIColor *)color
{
    UIView *viewTopLine = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, SINGLE_LINE_WIDTH)];
    
    viewTopLine.backgroundColor = color;
    viewTopLine.autoresizingMask = UIViewAutoresizingFlexibleWidth/* | UIViewAutoresizingFlexibleTopMargin*/;
    
    [self addSubview:viewTopLine];
    return viewTopLine;
}

- (UIView *)addTopUnitPixLine2:(UIColor *)color indent:(CGFloat)fIndent
{
    UIView *viewTopLine = [[UIView alloc] initWithFrame:CGRectMake(fIndent, 0.0, self.frame.size.width - fIndent, SINGLE_LINE_WIDTH)];
    
    viewTopLine.backgroundColor = color;
    viewTopLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:viewTopLine];
    return viewTopLine;
}

- (UIView *)addBottomLineWithWidth:(CGFloat)width color:(UIColor *)color
{
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.frame.size.height - width, self.frame.size.width, width)];
    
    bottomLine.backgroundColor = color;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:bottomLine];
    return bottomLine;
}

- (UIView *)addBottomUnitPixLine2:(UIColor *)color
{
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.frame.size.height - SINGLE_LINE_WIDTH, self.frame.size.width, SINGLE_LINE_WIDTH)];
    
    bottomLine.backgroundColor = color;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:bottomLine];
    return bottomLine;
}

- (UIView *)addBottomLineWithWidth:(CGFloat)width imageName:(NSString *)strImageName
{
    UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, self.frame.size.height - width, self.frame.size.width, width)];
    
    bottomLine.image = [UIImage imageNamed:strImageName];
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:bottomLine];
    return bottomLine;
}

- (UIView *)addBottomLineWithWidth:(CGFloat)width color:(UIColor *)color indent:(CGFloat)fIndent
{
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(fIndent, self.frame.size.height - width, self.frame.size.width - fIndent, width)];
    
    bottomLine.backgroundColor = color;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:bottomLine];
    return bottomLine;
}

- (UIView *)addBottomUnitPixLine2:(UIColor *)color indent:(CGFloat)fIndent
{
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(fIndent, self.frame.size.height - SINGLE_LINE_WIDTH, self.frame.size.width - fIndent, SINGLE_LINE_WIDTH)];
    
    bottomLine.backgroundColor = color;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:bottomLine];
    return bottomLine;
}

- (UIView *)addRightLineWithWidth:(CGFloat)width color:(UIColor *)color
{
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - width, 0.0f, width, self.frame.size.height)];
    vLine.backgroundColor = color;
    vLine.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    
    [self addSubview:vLine];
    return vLine;
}

- (UIView *)addRightUnitPixLine2:(UIColor *)color
{
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - SINGLE_LINE_WIDTH, 0.0f, SINGLE_LINE_WIDTH, self.frame.size.height)];
    vLine.backgroundColor = color;
    vLine.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    
    [self addSubview:vLine];
    return vLine;
}

- (UIView *)addLeftUnitPixLine2:(UIColor *)color
{
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0.0f, SINGLE_LINE_WIDTH, self.frame.size.height)];
    vLine.backgroundColor = color;
    vLine.autoresizingMask = UIViewAutoresizingFlexibleHeight/* | UIViewAutoresizingFlexibleRightMargin*/;
    
    [self addSubview:vLine];
    return vLine;
}

- (UIView *)addVerticalLineWithWidth:(CGFloat)width color:(UIColor *)color atX:(CGFloat)x
{
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(x, 0.0f, width, self.frame.size.height)];
    vLine.backgroundColor = color;
    vLine.autoresizingMask = UIViewAutoresizingFlexibleHeight/* | UIViewAutoresizingFlexibleRightMargin*/;
    
    [self addSubview:vLine];
    return vLine;
}

- (UIView *)addVerticalUnitPixLine:(UIColor *)color atX:(CGFloat)x
{
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(x, 0.0f, SINGLE_LINE_WIDTH, self.frame.size.height)];
    vLine.backgroundColor = color;
    vLine.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self addSubview:vLine];
    return vLine;
}

- (UIView *)addHorizontalLineWithHeight:(CGFloat)height color:(UIColor *)color atY:(CGFloat)y
{
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(0.0, y, self.frame.size.width, height)];
    vLine.backgroundColor = color;
    vLine.autoresizingMask = UIViewAutoresizingFlexibleWidth/* | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin*/;
    
    [self addSubview:vLine];
    return vLine;
}

- (UIView *)addHorizontalUnitPixLine:(UIColor *)color atY:(CGFloat)y
{
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, SINGLE_LINE_WIDTH)];
    vLine.backgroundColor = color;
    vLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:vLine];
    return vLine;
}

- (UIView *)addLineWithRect:(CGRect)rect color:(UIColor *)color
{
    UIView *vLine = [[UIView alloc] initWithFrame:rect];
    vLine.backgroundColor = color;
    [self addSubview:vLine];
    return vLine;
}

@end
