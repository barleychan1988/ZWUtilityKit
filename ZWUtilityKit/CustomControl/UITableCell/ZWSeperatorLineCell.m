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
    [self initSubviews];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initValues];
        [self initSubviews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initValues];
        [self initSubviews];
    }
    return self;
}

- (void)initValues
{
  _contentInset = UIEdgeInsetsMake(0, 15, 0, 15);

  if (@available(iOS 13.0, *)) {
    self.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * (UITraitCollection * trait) {
      if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
        return [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1];
      } else {
        return [UIColor whiteColor];
      }
    }];
  } else {
    self.backgroundColor = [UIColor whiteColor];
  }
}

- (void)initSubviews
{}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    _contentInset = contentInset;
    [self layoutIfNeeded];
}

#pragma mark - property

- (UIView *)topSeparatorLine
{
    return m_viewTopLine;
}

- (UIView *)bottomSeparatorLine
{
    return m_viewBottomLine;
}

#pragma mark -

- (void)showTopSeparatorLine:(BOOL)bShow color:(UIColor *)color
{
    if (color == nil)
        color = [[self class] defaultSeperatorLineColor];
    [m_viewTopLine removeFromSuperview];
    if (bShow)
    {
        m_viewTopLine = [self addTopUnitPixLine2:color];
    }
}

- (void)showTopSeparatorLine:(BOOL)bShow color:(UIColor *)color indent:(CGFloat)fIndent
{
    if (color == nil)
        color = [[self class] defaultSeperatorLineColor];
    [m_viewTopLine removeFromSuperview];
    if (bShow)
    {
        m_viewTopLine = [self addTopUnitPixLine2:color indent:fIndent];
    }
}

- (void)showBottomSeparatorLine:(BOOL)bShow color:(UIColor *)color
{
    if (color == nil)
        color = [[self class] defaultSeperatorLineColor];
    [m_viewBottomLine removeFromSuperview];
    if (bShow)
    {
        m_viewBottomLine = [self addBottomUnitPixLine2:color];
    }
}

- (void)showBottomSeparatorLine:(BOOL)bShow color:(UIColor *)color indent:(CGFloat)fIndent
{
    if (color == nil)
        color = [[self class] defaultSeperatorLineColor];
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
    
    CGRect frame = self.bounds;
    frame.origin.x = self.contentInset.left;
    frame.origin.y = self.contentInset.top;
    frame.size.width -= (self.contentInset.left + self.contentInset.right);
    frame.size.height -= (self.contentInset.top + self.contentInset.bottom);
    self.contentView.frame = frame;
    
    if (_isSelectedBackgroundSameWithContent)
        self.selectedBackgroundView.frame = frame;
    else
        self.selectedBackgroundView.frame = self.bounds;
}

+ (UIColor *)defaultSeperatorLineColor
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

@end
