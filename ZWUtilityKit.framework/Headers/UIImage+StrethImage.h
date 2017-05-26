//
//  UIImage+StrethImage.h
//  气泡
//
//  Created by zzy on 14-5-13.
//  Copyright (c) 2014年 zzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (StrethImage)

+(id)strethImageWith:(NSString *)imageName;
/*
 *  @brief：获取64x64的缩略图
 */
+ (UIImage *)generatePhotoThumbnail:(UIImage *)image;

- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)makeRoundCornerImage:(int)cornerSize;
- (UIImage *)convertImageToNegative;
/*
 *  @brief：以指定颜色值生成1x1的图片
 */
+ (UIImage *)pureColorImage:(UIColor *)color;

@end