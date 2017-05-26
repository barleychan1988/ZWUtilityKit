//
//  DiscoveryInfoImageCell.h
//  DIY
//
//  Created by chenzw on 15/12/30.
//  Copyright © 2015年 BiggerSister. All rights reserved.
//

/*
 *  @brief: 显示单个图片的单元格
 */
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIImageTableViewCellImageShowStyle)
{
    ImageShowStyle_ScaleFitByBig = 0,    //宽高等比缩放，按小得缩放，不能完全显示
    ImageShowStyle_ScaleFitBySmall,   //宽高等比缩放，按大得缩放，能完全显示
    ImageShowStyle_ScaleFit,      //宽高等比缩放，如果图片尺寸本身就小则不缩放,能完全显示
};

static NSString *g_strUITableViewImageCellID = @"UITableViewImageCellID";

@interface UITableViewImageCell : UITableViewCell

@property (nonatomic, retain)UIImage *image;
@property (nonatomic, assign)UIImageTableViewCellImageShowStyle styleImageShow;

@end