//
//  ZWIconTextFieldCell.m
//  Pods
//
//  Created by EadkennyChan on 17/6/12.
//
//

#import "ZWIconTextFieldCell.h"
#import "Masonry.h"
#import "ZWMacroDef.h"

NSString *const ZWIconTextFieldCellID = @"ZWIconTextFieldCellID";

@interface ZWIconTextFieldCell ()

@property (nonatomic, retain)UIImageView *imageViewIcon;

@end

@implementation ZWIconTextFieldCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    [self initSubviews];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        [self initSubviews];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        [self initSubviews];
    return self;
}

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
    
    ZWTextField *l = [[ZWTextField alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_textField = l];
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
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
    [_textField mas_remakeConstraints:blockText];
}

@end
