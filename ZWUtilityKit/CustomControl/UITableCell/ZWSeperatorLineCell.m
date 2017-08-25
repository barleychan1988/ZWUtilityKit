//
//  ZWSeperatorLineCell.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 17/5/29.
//  Copyright © 2017年 zwchen. All rights reserved.
//

#import "ZWSeperatorLineCell.h"
#import "UIView+AddLine.h"
#import "Masonry.h"

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
    
    __weak ZWSeperatorLineCell *weakobject = self;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakobject).offset(15);
        make.right.equalTo(weakobject).offset(-15);
        make.top.equalTo(weakobject);
        make.bottom.equalTo(weakobject);
    }];
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    _contentInset = contentInset;
    [self updateContentViewLayout];
}

- (void)updateContentViewLayout
{
    UIEdgeInsets contentInset = self.contentInset;
    __weak ZWSeperatorLineCell *weakobject = self;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakobject).offset(contentInset.left);
        make.right.equalTo(weakobject).offset(-contentInset.right);
        make.top.equalTo(weakobject).offset(contentInset.top);
        make.bottom.equalTo(weakobject).offset(-contentInset.bottom);
    }];
}

#pragma mark -

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

#pragma mark 支持高度设置

- (void)showTopLineWithColor:(nullable UIColor *)color height:(CGFloat)fHeight
{
    __weak UIView *weakself = self;
    [m_viewTopLine removeFromSuperview];
    if (color == nil)
        return;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    [self addSubview:m_viewTopLine = view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself);
        make.right.equalTo(weakself);
        make.top.equalTo(weakself);
        make.height.mas_equalTo(fHeight);
    }];
}
- (void)showTopLineWithColor:(nullable UIColor *)color height:(CGFloat)fHeight indent:(CGFloat)fIndent
{
    __weak UIView *weakself = self;
    [m_viewTopLine removeFromSuperview];
    if (color == nil)
        return;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    [self addSubview:m_viewTopLine = view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself).offset(fIndent);
        make.right.equalTo(weakself);
        make.top.equalTo(weakself);
        make.height.mas_equalTo(fHeight);
    }];
}
- (void)showTopLineWithImage:(nonnull UIImage *)image height:(CGFloat)fHeight
{
    __weak UIView *weakself = self;
    [m_viewTopLine removeFromSuperview];
    if (image == nil)
        return;
    UIImageView *view = [[UIImageView alloc] initWithImage:image];
    [self addSubview:m_viewTopLine = view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself);
        make.right.equalTo(weakself);
        make.top.equalTo(weakself);
        make.height.mas_equalTo(fHeight);
    }];
}
- (void)showTopLineWithImage:(nonnull UIImage *)image height:(CGFloat)fHeight indent:(CGFloat)fIndent
{
    __weak UIView *weakself = self;
    [m_viewTopLine removeFromSuperview];
    if (image == nil)
        return;
    UIImageView *view = [[UIImageView alloc] initWithImage:image];
    [self addSubview:m_viewTopLine = view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself).offset(fIndent);
        make.right.equalTo(weakself);
        make.top.equalTo(weakself);
        make.height.mas_equalTo(fHeight);
    }];
}
- (void)hiddenTopLine
{
    [m_viewTopLine removeFromSuperview];
    m_viewTopLine = nil;
}
- (void)showBottomLineWithColor:(nullable UIColor *)color height:(CGFloat)fHeight
{
    __weak UIView *weakself = self;
    [m_viewBottomLine removeFromSuperview];
    if (color == nil)
        return;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    [self addSubview:m_viewBottomLine = view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself);
        make.right.equalTo(weakself);
        make.bottom.equalTo(weakself);
        make.height.mas_equalTo(fHeight);
    }];
}
- (void)showBottomLineWithColor:(nullable UIColor *)color height:(CGFloat)fHeight indent:(CGFloat)fIndent
{
    __weak UIView *weakself = self;
    [m_viewBottomLine removeFromSuperview];
    if (color == nil)
        return;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    [self addSubview:m_viewBottomLine = view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself).offset(fIndent);
        make.right.equalTo(weakself);
        make.bottom.equalTo(weakself);
        make.height.mas_equalTo(fHeight);
    }];
}
- (void)showBottomLineWithImage:(nonnull UIImage *)image height:(CGFloat)fHeight
{
    __weak UIView *weakself = self;
    [m_viewBottomLine removeFromSuperview];
    if (image == nil)
        return;
    UIImageView *view = [[UIImageView alloc] initWithImage:image];
    [self addSubview:m_viewBottomLine = view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself);
        make.right.equalTo(weakself);
        make.bottom.equalTo(weakself);
        make.height.mas_equalTo(fHeight);
    }];
}
- (void)showBottomLineWithImage:(nonnull UIImage *)image height:(CGFloat)fHeight indent:(CGFloat)fIndent
{
    __weak UIView *weakself = self;
    [m_viewBottomLine removeFromSuperview];
    if (image == nil)
        return;
    UIImageView *view = [[UIImageView alloc] initWithImage:image];
    [self addSubview:m_viewBottomLine = view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself).offset(fIndent);
        make.right.equalTo(weakself);
        make.bottom.equalTo(weakself);
        make.height.mas_equalTo(fHeight);
    }];
}
- (void)hiddenBottomLine
{
    [m_viewBottomLine removeFromSuperview];
    m_viewBottomLine = nil;
}

#pragma mark - 

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_isSelectedBackgroundSameWithContent)
        self.selectedBackgroundView.frame = self.contentView.frame;
    else
        self.selectedBackgroundView.frame = self.bounds;
}

- (UIColor *)defaultSeperatorLineColor
{
    return [UIColor colorWithRed:(221)/255.0f green:(221)/255.0f blue:(221)/255.0f alpha:1];
}

@end
