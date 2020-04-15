//
//  ZWIconLabelCell.m
//  Pods
//
//  Created by EadkennyChan on 17/5/30.
//
//

#import "ZWIconLabelCell.h"
#import "Masonry.h"
#import "ZWMacroDef.h"
#import "UtilityUIKit.h"

NSString *const ZWIconLabelCellID = @"ZWIconLabelCellID";

@interface ZWIconLabelCell ()

@property (nonatomic, retain)UIImageView *imageViewIcon;

@end

@implementation ZWIconLabelCell

@synthesize textLabel = _textLabel;

- (void)initSubviews
{
  UIImageView *imgV = [[UIImageView alloc] init];
  imgV.hidden = YES;
  [self.contentView addSubview:_imageViewIcon = imgV];
  
  UILabel *l = [[UILabel alloc] init];
  [self.contentView addSubview:_textLabel = l];
}

- (NSString *)text
{
  return _textLabel.text;
}

- (void)setText:(NSString *)text
{
  _textLabel.text = text;
}

- (void)setIcon:(UIImage *)icon
{
  _icon = icon;
  _imageViewIcon.image = _icon;

  if (icon == nil)
  {
    _imageViewIcon.hidden = YES;
  }
  else
  {
    _imageViewIcon.hidden = NO;
  }
}

- (void)showAccessory:(BOOL)bShow image:(UIImage *)image
{
    [super showAccessory:bShow image:image];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGRect rectTmp = self.contentView.bounds;
  if (_icon) {
    rectTmp.size = _icon.size;
    rectTmp.origin.y = (self.contentView.bounds.size.height - rectTmp.size.height) / 2;
    _imageViewIcon.frame = rectTmp;
    rectTmp.origin.x += rectTmp.size.width;
  }
  //
  rectTmp.origin.x += _fWidthDiff;
  rectTmp.origin.y = self.contentView.bounds.origin.y;
  rectTmp.size.height = self.contentView.bounds.size.height;
  CGFloat fAccessoryWidth = [self widthOfAccessory];
  rectTmp.size.width = self.contentView.bounds.size.width - fAccessoryWidth - rectTmp.origin.x;
  _textLabel.frame = rectTmp;
}

@end

#pragma mark - 

NSString *const ZWIconLLCellID = @"ZWIconLLCellID";

@interface ZWIconLLCell()

@end

@implementation ZWIconLLCell

@synthesize detailTextLabel = _detailTextLabel;

- (void)initSubviews
{
    [super initSubviews];
    
    UILabel *l = [[UILabel alloc] init];
    l.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_detailTextLabel = l];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGRect rectTmp = self.textLabel.frame;
  if (_fTextWidth > 0) {
    rectTmp.size.width = _fTextWidth;
  } else {
    CGFloat fWidthText = getSizeForLabelText(self.textLabel.text, self.textLabel.font, CGSizeZero).width;
    rectTmp.size.width = fWidthText;
  }
  self.textLabel.frame = rectTmp;
//
  rectTmp.origin.x += rectTmp.size.width;
  rectTmp.size.width = self.contentView.bounds.size.width - [self widthOfAccessory] - rectTmp.origin.x;
  rectTmp.origin.y = self.contentView.bounds.origin.y;
  rectTmp.size.height = self.contentView.bounds.size.height;
  _detailTextLabel.frame = rectTmp;
}

@end

#pragma mark -

NSString *const ZWIconLabelTFCellID = @"ZWIconLableTFCellID";

@interface ZWIconLabelTFCell()

@end

@implementation ZWIconLabelTFCell

- (void)initSubviews
{
    [super initSubviews];
    
    UITextField *l = [[UITextField alloc] init];
    l.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_detailTextField = l];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGRect rectTmp = self.textLabel.frame;
  if (_fTextWidth > 0) {
    rectTmp.size.width = _fTextWidth;
  } else {
    CGFloat fWidthText = getSizeForLabelText(self.textLabel.text, self.textLabel.font, CGSizeZero).width;
    rectTmp.size.width = fWidthText;
  }
  self.textLabel.frame = rectTmp;
//
  rectTmp.origin.x += rectTmp.size.width;
  rectTmp.size.width = self.contentView.bounds.size.width - [self widthOfAccessory] - rectTmp.origin.x;
  rectTmp.origin.y = self.contentView.bounds.origin.y;
  rectTmp.size.height = self.contentView.bounds.size.height;
  _detailTextField.frame = rectTmp;
}

@end
