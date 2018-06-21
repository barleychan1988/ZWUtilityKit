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
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(self.icon.size);
    }];
    
    UILabel *l = [[UILabel alloc] init];
    [self.contentView addSubview:_textLabel = l];
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
}

- (NSString *)text
{
    return _textLabel.text;
}

- (void)setText:(NSString *)text
{
    _textLabel.text = text;
    [self updateLayout];
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
    [self updateLayout];
}

- (void)setFWidthDiff:(CGFloat)fWidthDiff
{
    _fWidthDiff = fWidthDiff;
    [self updateLayout];
}

- (void)showAccessory:(BOOL)bShow image:(UIImage *)image
{
    [super showAccessory:bShow image:image];
    [self updateLayout];
}

- (void)updateLayout
{
    UIImageView *imageViewAccessory = (UIImageView *)self.accessoryView;
    UIImageView *imageViewIcon = _imageViewIcon;
    
    BlockObject blockIcon;
    BlockObject blockText;
    if (_icon)
    {
        blockIcon = ^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.icon.size);
            
            make.left.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
        };
        [imageViewIcon mas_remakeConstraints:blockIcon];
        
        if (imageViewAccessory.superview)
        {
            blockText = ^(MASConstraintMaker *make) {
                make.left.equalTo(imageViewIcon.mas_right).offset(self.fWidthDiff);
                make.right.equalTo(self.contentView).offset(-self.fWidthDiff);
                
                make.top.equalTo(self.contentView);
                make.bottom.equalTo(self.contentView);
            };
        }
        else
        {
            blockText = ^(MASConstraintMaker *make) {
                make.left.equalTo(imageViewIcon.mas_right).offset(self.fWidthDiff);
                make.right.equalTo(self.contentView);
                
                make.top.equalTo(self.contentView);
                make.bottom.equalTo(self.contentView);
            };
        }
    }
    else
    {
        if (imageViewAccessory.superview)
        {
            blockText = ^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView);
                make.right.equalTo(self.contentView).offset(-self.fWidthDiff);
                
                make.top.equalTo(self.contentView);
                make.bottom.equalTo(self.contentView);
            };
        }
        else
        {
            blockText = ^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView);
                make.right.equalTo(self.contentView);
                
                make.top.equalTo(self.contentView);
                make.bottom.equalTo(self.contentView);
            };
        }
    }
    [_textLabel mas_remakeConstraints:blockText];
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
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.textLabel.mas_right);
    }];
}

- (void)updateLayout
{
    UIImageView *imageViewAccessory = (UIImageView *)self.accessoryView;
    UIImageView *imageViewIcon = self.imageViewIcon;
    CGFloat fWidthDiff = self.fWidthDiff;
    
    UILabel *labelDetail = _detailTextLabel;
    UILabel *labelText = self.textLabel;
    CGFloat fWidthText = getSizeForLabelText(labelText.text, labelText.font, CGSizeZero).width;
    
    BlockObject blockIcon;
    BlockObject blockText;
    BlockObject blockDetailText;
    
    if (imageViewAccessory.superview)
    {
        blockDetailText = ^(MASConstraintMaker *make){
            make.left.equalTo(labelText.mas_right);
            if (fWidthText == 0)
                make.width.equalTo(labelText.mas_width);
            make.right.equalTo(self.contentView).offset(-fWidthDiff);
            
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        };
    }
    else
    {
        blockDetailText = ^(MASConstraintMaker *make){
            make.left.equalTo(labelText.mas_right);
            if (fWidthText == 0)
                make.width.equalTo(labelText.mas_width);
            make.right.equalTo(self.contentView);
            
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        };
    }
    
    if (self.icon)
    {
        blockIcon = ^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.icon.size);
            
            make.left.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
        };
        [imageViewIcon mas_remakeConstraints:blockIcon];
        
        blockText = ^(MASConstraintMaker *make) {
            make.left.equalTo(imageViewIcon.mas_right).offset(fWidthDiff);
            make.right.equalTo(labelDetail.mas_left);
            if (self.fTextWidth > fWidthText)
                make.width.mas_equalTo(self.fTextWidth);
            else if (fWidthText == 0)
                make.width.equalTo(labelDetail.mas_width);
            else
                make.width.mas_equalTo(fWidthText);
            
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        };
    }
    else
    {
        blockText = ^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(labelDetail.mas_left);
            if (self.fTextWidth > fWidthText)
                make.width.mas_equalTo(self.fTextWidth);
            else if (fWidthText == 0)
                make.width.equalTo(labelDetail.mas_width);
            else
                make.width.mas_equalTo(fWidthText);
            
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        };
    }
    [labelDetail mas_remakeConstraints:blockDetailText];
    [labelText mas_remakeConstraints:blockText];
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
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.textLabel.mas_right);
    }];
}

- (void)updateLayout
{
    UIImageView *imageViewAccessory = (UIImageView *)self.accessoryView;
    UIImageView *imageViewIcon = self.imageViewIcon;
    CGFloat fWidthDiff = self.fWidthDiff;
    
    UILabel *labelDetail = (UILabel *)_detailTextField;
    UILabel *labelText = self.textLabel;
    CGFloat fWidthText = getSizeForLabelText(labelText.text, labelText.font, CGSizeZero).width;
    
    BlockObject blockIcon;
    BlockObject blockText;
    BlockObject blockDetailText;
    
    if (imageViewAccessory.superview)
    {
        blockDetailText = ^(MASConstraintMaker *make){
            make.left.equalTo(labelText.mas_right);
            if (fWidthText == 0)
                make.width.equalTo(labelText.mas_width);
            make.right.equalTo(self.contentView).offset(-fWidthDiff);
            
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        };
    }
    else
    {
        blockDetailText = ^(MASConstraintMaker *make){
            make.left.equalTo(labelText.mas_right);
            if (fWidthText == 0)
                make.width.equalTo(labelText.mas_width);
            make.right.equalTo(self.contentView);
            
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        };
    }
    
    if (self.icon)
    {
        blockIcon = ^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.icon.size);
            
            make.left.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
        };
        [imageViewIcon mas_remakeConstraints:blockIcon];
        
        blockText = ^(MASConstraintMaker *make) {
            make.left.equalTo(imageViewIcon.mas_right).offset(fWidthDiff);
            make.right.equalTo(labelDetail.mas_left);
            if (self.fTextWidth > fWidthText)
                make.width.mas_equalTo(self.fTextWidth);
            else if (fWidthText == 0)
                make.width.equalTo(labelDetail.mas_width);
            else
                make.width.mas_equalTo(fWidthText);
            
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        };
    }
    else
    {
        blockText = ^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(labelDetail.mas_left);
            if (self.fTextWidth > fWidthText)
                make.width.mas_equalTo(self.fTextWidth);
            else if (fWidthText == 0)
                make.width.equalTo(labelDetail.mas_width);
            else
                make.width.mas_equalTo(fWidthText);
            
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        };
    }
    [labelDetail mas_remakeConstraints:blockDetailText];
    [labelText mas_remakeConstraints:blockText];
}

- (void)showAccessory:(BOOL)bShow image:(UIImage *)image
{
    [super showAccessory:bShow image:image];
    [self updateLayout];
}

@end
