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
    _isSelectedBackgroundSameWithContent = YES;
}

- (void)showTopSeparatorLine:(BOOL)bShow color:(UIColor *)color
{
    if (color == nil)
        color = [self defaultSeperatorLineColor];
    [m_viewTopLine removeFromSuperview];
    if (bShow)
    {
        m_viewTopLine = [self addTopUnitPixLine2:color];
    }
}

- (void)showTopSeparatorLine:(BOOL)bShow color:(UIColor *)color indent:(CGFloat)fIndent
{
    if (color == nil)
        color = [self defaultSeperatorLineColor];
    [m_viewTopLine removeFromSuperview];
    if (bShow)
    {
        m_viewTopLine = [self addTopUnitPixLine2:color indent:fIndent];
    }
}

- (void)showBottomSeparatorLine:(BOOL)bShow color:(UIColor *)color
{
    if (color == nil)
        color = [self defaultSeperatorLineColor];
    [m_viewBottomLine removeFromSuperview];
    if (bShow)
    {
        m_viewBottomLine = [self addBottomUnitPixLine2:color];
    }
}

- (void)showBottomSeparatorLine:(BOOL)bShow color:(UIColor *)color indent:(CGFloat)fIndent
{
    if (color == nil)
        color = [self defaultSeperatorLineColor];
    [m_viewBottomLine removeFromSuperview];
    if (bShow)
    {
        m_viewBottomLine = [self addBottomUnitPixLine2:color indent:fIndent];
    }
}

/*
@synthesize contentView = _contentView;

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    _contentInset = contentInset;
    self.contentView;
}

- (UIView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[UIView alloc] init];
        [[super contentView] addSubview:_contentView];
    }
    return _contentView;
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGRect frame = super.contentView.bounds;
    CGRect frame = self.bounds;
    frame.origin.x += _contentInset.left;
    frame.origin.y += _contentInset.top;
    frame.size.width -= (_contentInset.left + _contentInset.right);
    frame.size.height -= (_contentInset.top + _contentInset.bottom);
//    _contentView.frame = frame;
    self.contentView.frame = frame;
    if (_isSelectedBackgroundSameWithContent)
        self.selectedBackgroundView.frame = frame;
    else
        self.selectedBackgroundView.frame = self.bounds;
}

- (UIColor *)defaultSeperatorLineColor
{
    return [UIColor colorWithRed:(221)/255.0f green:(221)/255.0f blue:(221)/255.0f alpha:1];
}

@end
