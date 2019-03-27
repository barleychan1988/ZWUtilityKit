//
//  JgwContentCell.h
//  BaseUI
//
//  Created by Eadkenny on 2019/3/25.
//

#import <UIKit/UIKit.h>
#import "EadSeparatorLineCell.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN  NSString *_Nonnull const EadContentCellID;

@interface EadContentCell<__covariant ObjectType> : EadSeparatorLineCell

@property (nonatomic, retain, readonly)ObjectType mainView;

- (void)setupContentView:(UIView *)customView;
- (void)setupContentViewClass:(Class)cls;

@end

NS_ASSUME_NONNULL_END
