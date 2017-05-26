//
//  ZWImageHandle.h
//  DIY
//
//  Created by chenzw on 15/10/12.
//  Copyright © 2015年 BiggerSister. All rights reserved.
//

#import <UIKit/UIImage.h>

@interface UIImage (ZWHandle)

/*
 *  @brief: 获取图片对象中的像素数据
 *      返回的数据内存需要手动free
 */
- (uint32_t *)copyImagePixelData;
+ (UIImage*) imageBlackToTransparent:(UIImage*)image;
/*
 *  @brief：将图片非透明区域设置为白色
 */
+ (UIImage*) imageOpacityToWhite:(UIImage*) image;
/*
 *  @brief：将图片透明区域设置为指定颜色
 */
+ (UIImage*)imageConvertTransparent:(UIImage*)image toColorWithRed:(int)nRed green:(int)nGreen blue:(int)nBlue opacityToTransparent:(BOOL)bReverse;

#pragma mark - thumb image
/*
 *  @brief: 将图片输出指定大小
 */
- (UIImage *)outputImageWithSize:(CGSize)size;
/*
 *  @brief: 将图片按指定缩放比例输出
 */
- (UIImage *)outputImageWithScale:(CGFloat)scaleRatio;
/*
 *  @brief: 将图片按指定大小输出圆形图片
 */
- (UIImage *)outputCircleImageWithWidth:(CGFloat)fWidth;
/*
 *  @brief: 将图片按指定缩放比例输出圆形图片
 */
- (UIImage *)outputCircleImageWithScale:(CGFloat)scaleRatio;
/*
 *  @brief: 将图片按指定最大大小输出
 *      图片在指定size中进行等比缩放取最大size
 */
- (UIImage *)outputImageWithMaxSize:(CGSize)size;

#pragma mark - crop image
/*
 *  @brief: 裁剪图片指定位置图片内容
 *  @param: 
 *      frame: size不能比大小大
 */
- (UIImage *)cropImageWithRect:(CGRect)frame;

@end
