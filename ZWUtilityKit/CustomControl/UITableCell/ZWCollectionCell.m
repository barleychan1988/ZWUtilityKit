//
//  ZWCollectionCell.m
//  Pods
//
//  Created by EadkennyChan on 17/6/19.
//
//

#import "ZWCollectionCell.h"

NSString *const ZWCollectionCellID = @"ZWCollectionCellID";

@implementation ZWCollectionCell

- (void)initValues
{
    [self initCollectionView];
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0.0;
    flowLayout.minimumInteritemSpacing = 0.0;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:flowLayout];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.scrollsToTop = NO;
    _collectionView = collectionView;
    [self.contentView addSubview:collectionView];
}

@end
