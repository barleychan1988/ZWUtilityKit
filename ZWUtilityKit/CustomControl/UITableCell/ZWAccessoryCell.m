//
//  ZWAccessoryCell.m
//  Pods
//
//  Created by EadkennyChan on 17/6/9.
//
//

#import "ZWAccessoryCell.h"
#import "Masonry.h"

@interface ZWAccessoryCell ()
{
    UIImageView *m_imageViewAccessory;
}
@end

@implementation ZWAccessoryCell
    
- (UIView *)accessoryView
{
    return m_imageViewAccessory;
}

- (void)initValues
{
    [super initValues];
    _fWidthRight = 15.0;
}

- (void)updateContentViewLayout
{
    UIEdgeInsets contentInset = self.contentInset;
    __weak ZWSeperatorLineCell *weakobject = self;
    __weak UIView *viewAccessory = m_imageViewAccessory;
    if (m_imageViewAccessory.superview)
    {
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakobject).offset(contentInset.left);
            make.right.equalTo(viewAccessory.mas_left).offset(-contentInset.right);
            make.top.equalTo(weakobject).offset(contentInset.top);
            make.bottom.equalTo(weakobject).offset(-contentInset.bottom);
        }];
    }
    else
    {
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakobject).offset(contentInset.left);
            make.right.equalTo(weakobject).offset(-contentInset.right);
            make.top.equalTo(weakobject).offset(contentInset.top);
            make.bottom.equalTo(weakobject).offset(-contentInset.bottom);
        }];
    }
}

- (void)showAccessory:(BOOL)bShow image:(nullable UIImage *)image
{
  if (!bShow || !image) {
    return [self hiddenAccessory];
  }
  [m_imageViewAccessory removeFromSuperview];
  UIImageView *imgV = [[UIImageView alloc] initWithImage:image];
  [self addSubview:m_imageViewAccessory = imgV];
  [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(self).offset(-self.fWidthRight);
      make.centerY.equalTo(self);
      make.size.mas_equalTo(image.size);
  }];
  [self updateContentViewLayout];
}

- (void)showAccessory:(BOOL)bShow imageName:(nullable NSString *)imageName
{
  if (bShow) {
    UIImage *image = [UIImage imageNamed:imageName];
    [self showAccessory:bShow image:image];
  } else {
    [self hiddenAccessory];
  }
}

- (void)showCustomAccessory:(UIImageView *)view withSize:(CGSize)size
{
    [m_imageViewAccessory removeFromSuperview];
    if (view == nil || CGSizeEqualToSize(size, CGSizeZero))
    {
        return;
    }
    CGRect frame = CGRectZero;
    frame.size = size;
    view.frame = frame;
    [self addSubview:m_imageViewAccessory = view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-self.fWidthRight);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(size);
    }];
    [self updateContentViewLayout];
}

- (void)showCustomAccessory:(UIImageView *)view {
  [m_imageViewAccessory removeFromSuperview];
  if (view == nil) {
    return;
  }
  CGRect frame = CGRectZero;
  frame.size = view.frame.size;
  view.frame = frame;
  [self addSubview:m_imageViewAccessory = view];
  [view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).offset(-self.fWidthRight);
    make.centerY.equalTo(self);
    make.size.mas_equalTo(frame.size);
  }];
  [self updateContentViewLayout];
}

- (void)hiddenAccessory
{
    [m_imageViewAccessory removeFromSuperview];
    m_imageViewAccessory = nil;
    [self updateContentViewLayout];
}

- (void)setFWidthRight:(CGFloat)fWidthRight
{
    _fWidthRight = fWidthRight;
    [m_imageViewAccessory mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-fWidthRight);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark

- (CGFloat)widthOfAccessory {
  if (m_imageViewAccessory) {
    return _fWidthRight + m_imageViewAccessory.frame.size.width;
  }
  return 0;
}

@end
