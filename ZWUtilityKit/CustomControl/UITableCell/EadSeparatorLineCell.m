//
//  EadSeparatorLineCell.m
//  Pods
//
//  Created by zwchen on 2017/6/22.
//
//

#import "EadSeparatorLineCell.h"
#import "UIView+AddLine.h"
#import "Masonry.h"

@interface EadSeparatorLineCell()
{
    __weak UIView *m_viewTopLine;
    __weak UIView *m_viewBottomLine;
}
@end

NSString *const EadSeparatorLineCellID = @"EadSeparatorLineCellID";

@implementation EadSeparatorLineCell

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

#pragma mark - property

@synthesize mainView = _mainView;

- (UIView *)mainView
{
    if (_mainView == nil)
    {
        _mainView = [[UIView alloc] init];
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).with.insets(self.contentInset);
        }];
    }
    return _mainView;
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    _contentInset = contentInset;
    [[self mainView] mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(contentInset);
    }];
}

#pragma mark - method

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

- (UIColor *)defaultSeperatorLineColor
{
    return [UIColor colorWithRed:(221)/255.0f green:(221)/255.0f blue:(221)/255.0f alpha:1];
}

@end
