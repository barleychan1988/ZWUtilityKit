//
//  JgwContentCell.m
//  BaseUI
//
//  Created by Eadkenny on 2019/3/25.
//

#import "EadContentCell.h"
#import "Masonry.h"

NSString *const EadContentCellID = @"EadContentCellID";
@interface EadContentCell ()
{
    UIView *m_contentView;
}
@end

@implementation EadContentCell

- (UIView *)mainView
{
    if (m_contentView == nil)
    {
        m_contentView = [[UIView alloc] init];
        [self.contentView addSubview:m_contentView];
        [m_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).with.insets(self.contentInset);
        }];
    }
    return m_contentView;
}

- (void)setupContentView:(UIView *)customView
{
    if (m_contentView.superview)
    {
        [m_contentView removeFromSuperview];
    }
    m_contentView = customView;
    [[self contentView] addSubview:customView];
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(self.contentInset);
    }];
}

- (void)setupContentViewClass:(Class)cls
{
    if (![[m_contentView class] isEqual:cls])
    {
        m_contentView = [[cls alloc] init];
        [[self contentView] addSubview:m_contentView];
        [(UIView *)m_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).with.insets(self.contentInset);
        }];
    }
}

@end
