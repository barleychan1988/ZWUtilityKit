//
//  ZWSeperatorLineCell.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/5/29.
//  Copyright © 2017年 zwchen. All rights reserved.
//

#import "ZWSeperatorLineCell.h"
#import "UIView+AddLine.h"

@interface ZWSeperatorLineCell()
{
    __weak UIView *m_viewTopLine;
    __weak UIView *m_viewBottomLine;
}
@end

NSString *const ZWSeperatorLineCellID = @"ZWSeperatorLineCellID";

@implementation ZWSeperatorLineCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    [self initValues];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        [self initValues];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        [self initValues];
    return self;
}

- (void)initValues
{
    _contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
}

- (void)showTopSeparatorLine:(BOOL)bShow color:(UIColor *)color
{
    if (color == nil)
        color = [self defaultSeperatorLineColor];
    if (bShow)
    {
        if (m_viewTopLine.superview == nil)
            m_viewTopLine = [self addTopUnitPixLine2:color];
    }
    else
        [m_viewTopLine removeFromSuperview];
}

- (void)showTopSeparatorLine:(BOOL)bShow color:(UIColor *)color indent:(CGFloat)fIndent
{
    if (color == nil)
        color = [self defaultSeperatorLineColor];
    if (bShow)
    {
        if (m_viewTopLine.superview == nil)
            m_viewTopLine = [self addTopUnitPixLine2:color indent:fIndent];
    }
    else
        [m_viewTopLine removeFromSuperview];
}

- (void)showBottomSeparatorLine:(BOOL)bShow color:(UIColor *)color
{
    if (color == nil)
        color = [self defaultSeperatorLineColor];
    if (bShow)
    {
        if (m_viewBottomLine.superview == nil)
            m_viewBottomLine = [self addBottomUnitPixLine2:color];
    }
    else
        [m_viewBottomLine removeFromSuperview];
}

- (void)showBottomSeparatorLine:(BOOL)bShow color:(UIColor *)color indent:(CGFloat)fIndent
{
    if (color == nil)
        color = [self defaultSeperatorLineColor];
    if (bShow)
    {
        if (m_viewBottomLine.superview == nil)
            m_viewBottomLine = [self addBottomUnitPixLine2:color indent:fIndent];
    }
    else
        [m_viewBottomLine removeFromSuperview];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    frame.origin.x += _contentInset.left;
    frame.origin.y += _contentInset.top;
    frame.size.width -= (_contentInset.left + _contentInset.right);
    frame.size.height -= (_contentInset.top + _contentInset.bottom);
    self.contentView.frame = frame;
}

- (UIColor *)defaultSeperatorLineColor
{
    return [UIColor colorWithRed:(221)/255.0f green:(221)/255.0f blue:(221)/255.0f alpha:1];
}

@end
