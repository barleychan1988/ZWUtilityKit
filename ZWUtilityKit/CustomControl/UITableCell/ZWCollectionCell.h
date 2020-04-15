//
//  ZWCollectionCell.h
//  Pods
//
//  Created by EadkennyChan on 17/6/19.
//
//

#import "ZWSeperatorLineCell.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *_Nonnull const ZWCollectionCellID;

@interface ZWCollectionCell : ZWSeperatorLineCell

@property (nonatomic, readonly, retain, nonnull)UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
