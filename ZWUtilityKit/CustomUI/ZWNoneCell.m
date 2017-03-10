//
//  NoneContentCell.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/10/17.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#import "ZWNoneCell.h"
#import "UIView+AddLine.h"

NSString *const ZWNoneCellID = @"ZWNoneCellID";
@interface ZWNoneCell()
{
    UIView *m_viewBottomLine;
}
@end

@implementation ZWNoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showSeparatorLine:(BOOL)bShow indent:(CGFloat)fIndex color:(UIColor *)color
{
    [m_viewBottomLine removeFromSuperview];
    m_viewBottomLine = nil;
    if (bShow)
    {
        m_viewBottomLine = [self addBottomUnitPixLine2:color indent:fIndex];
    }
}

@end
