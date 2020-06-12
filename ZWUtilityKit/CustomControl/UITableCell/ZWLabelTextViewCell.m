//
//  ZWLabelTextViewCell.m
//  SCBase
//
//  Created by Eadkenny on 2018/1/19.
//

#import "ZWLabelTextViewCell.h"
#import "UtilityUIKit.h"

NSString *const ZWLabelTextViewCellID = @"ZWLabelTextViewCellID";

@implementation ZWLabelTextViewCell

- (void)initSubviews
{
    _fContentViewTopOffset = 5;
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = RGBSAMECOLOR(170);
    _labelTextTip = label;
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView.mas_width);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
    UITextView *textView = [[UITextView alloc] init];
  textView.backgroundColor = [UIColor clearColor];
    _textViewContent = textView;
    [self.contentView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(_fContentViewTopOffset);
        make.bottom.equalTo(self.contentView);
    }];
}

#pragma mark - property

- (void)setFTextWidth:(CGFloat)fTextWidth
{
    _fTextWidth = fTextWidth;
    [self.labelTextTip mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(fTextWidth);
        if (_fHeightTipView > 0)
            make.height.mas_equalTo(_fHeightTipView);
        else
            make.height.mas_equalTo(self.contentView.mas_height);
    }];
}

- (void)setFHeightTipView:(CGFloat)fHeightTipView
{
    _fHeightTipView = fHeightTipView;
    [self.labelTextTip mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        if (_fTextWidth > 0)
            make.width.mas_equalTo(_fTextWidth);
        else
            make.width.mas_equalTo(self.contentView.mas_width);
        make.height.mas_equalTo(fHeightTipView);
    }];
}

- (void)setFContentViewTopOffset:(CGFloat)fContentViewTopOffset
{
    _fContentViewTopOffset = fContentViewTopOffset;
    [_textViewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labelTextTip.mas_right);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(fContentViewTopOffset);
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
