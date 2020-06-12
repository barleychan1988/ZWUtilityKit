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
@property (nonatomic, assign) CGFloat   fWidthLine;
/**
 * @brief 网格颜色，默认grayColor
 */
@property (nonatomic, strong) UIColor   *colorLine;

@property (nonatomic, assign)GridLineType typeLine;

@end

@implementation SeperatorLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        
        _colorLine = [UIColor grayColor];
        _fWidthLine = SINGLE_LINE_WIDTH;
    }
    
    return self;
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
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        if (color) _colorLine = color;
        _fWidthLine = SINGLE_LINE_WIDTH;
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
            xStart =  0;
            yStart =  SINGLE_LINE_WIDTH;
            xEnd = self.frame.size.width;
            yEnd = yStart;
            break;
        case GridLineType_Right:
            xStart = self.frame.size.width - SINGLE_LINE_WIDTH;
            yStart =  0;
            xEnd = xStart;
            yEnd = self.frame.size.height;
            break;
        case GridLineType_Bottom:
        {
            xStart =  0;
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
            yStart =  0;
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

@end

//
//  UIView+AddLine.m
//  ZWMultiTbv
//
//  Created by chenzhengwang on 13-12-6.
//  Copyright (c) 2013年 zwchen. All rights reserved.
//

@implementation UIView(AddLine)

- (UIColor *)defaultLineColor
{
  UIColor *mainColor;
  if (@available(iOS 13.0, *)) {
    mainColor = [UIColor colorWithDynamicProvider:^UIColor * (UITraitCollection * trait) {
      if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
        return [UIColor colorWithRed:(53)/255.0f green:(53)/255.0f blue:(53)/255.0f alpha:1];
      } else {
        return [UIColor colorWithRed:(221)/255.0f green:(221)/255.0f blue:(221)/255.0f alpha:1];
      }
    }];
  } else {
    mainColor = [UIColor colorWithRed:(221)/255.0f green:(221)/255.0f blue:(221)/255.0f alpha:1];
  }
  return mainColor;
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

- (UIView *)addTopUnitPixLine:(UIColor *)color
{
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:self.bounds color:color];
    view.typeLine = GridLineType_Top;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:view];
    return view;
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

- (UIView *)addBottomUnitPixLine:(UIColor *)color
{
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:self.bounds color:color];
    view.typeLine = GridLineType_Bottom;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:view];
    return view;
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

- (UIView *)addBottomUnitPixLine:(UIColor *)color indent:(CGFloat)fIndent
{
    CGRect frame = self.bounds;
    frame.origin.x = fIndent;
    frame.size.width -= frame.origin.x;
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:frame color:color];
    view.typeLine = GridLineType_Bottom;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:view];
    return view;
}

- (UIView *)addRightUnitPixLine:(UIColor *)color
{
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:self.bounds color:color];
    view.typeLine = GridLineType_Right;
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:view];
    return view;
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

- (UIView *)addLeftUnitPixLine:(UIColor *)color
{
    SeperatorLineView *view = [[SeperatorLineView alloc] initWithFrame:self.bounds color:color];
    view.typeLine = GridLineType_Left;
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    return view;
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

- (UIView *)addHorizontalLineWithColor:(UIColor *)color constraints:(void(^)(MASConstraintMaker *make))block
{
    UIView *vLine = [[UIView alloc] init];
    if (color)
    {
        vLine.backgroundColor = color;
    }
    else
    {
        vLine.backgroundColor = [self defaultLineColor];
    }
    [self addSubview:vLine];
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        block(make);
        make.height.mas_equalTo(SINGLE_LINE_WIDTH);
    }];
    return vLine;
}

- (UIView *)addVerticalineWithColor:(UIColor *)color constraints:(void(^)(MASConstraintMaker *make))block
{
    UIView *vLine = [[UIView alloc] init];
    if (color)
    {
        vLine.backgroundColor = color;
    }
    else
    {
        vLine.backgroundColor = [self defaultLineColor];
    }
    [self addSubview:vLine];
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        block(make);
        make.width.mas_equalTo(SINGLE_LINE_WIDTH);
    }];
    return vLine;
}

@end
