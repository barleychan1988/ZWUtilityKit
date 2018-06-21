//
//  ZWImageHandle.m
//  DIY
//
//  Created by chenzw on 15/10/12.
//  Copyright © 2015年 BiggerSister. All rights reserved.
//

#import "UIImage+ZWHandle.h"
#import <UIKit/UIKit.h>

@implementation UIImage (ZWHandle)

- (uint32_t *)copyImagePixelData
{
    size_t width = CGImageGetWidth(self.CGImage);
    size_t height = CGImageGetHeight(self.CGImage);
    size_t bitmapBytesPerRow = CGImageGetBytesPerRow(self.CGImage);
    size_t bitsPerComponent = CGImageGetBitsPerComponent(self.CGImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    uint32_t *pBitmapData = (uint32_t *)malloc(bitmapBytesPerRow * height); //分配足够容纳图片字节数的内存空间 需手动free
    
    CGContextRef offscreenContext = CGBitmapContextCreate(pBitmapData, width, height, bitsPerComponent, bitmapBytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), self.CGImage); //将目标图像绘制到指定的上下文，实际为上下文内的bitmapData。 内存暴涨
    uint32_t *data = CGBitmapContextGetData (offscreenContext);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(offscreenContext);//释放上面的函数创建的上下文
    
//    free(pBitmapData);
    pBitmapData = nil;
    
    return data;
}

+ (UIImage*) imageBlackToTransparent:(UIImage*)image
{
    NSLog(@"为实现");
    return nil;
}

+ (UIImage*)imageOpacityToWhite:(UIImage*)image
{
    uint32_t *rgbImageBuf = [image copyImagePixelData];
    // 遍历像素
    const size_t imagePixelWidth = CGImageGetWidth(image.CGImage);
    const size_t imagePixelHeight = CGImageGetHeight(image.CGImage);
    size_t pixelNum = imagePixelWidth * imagePixelHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    
    uint32_t nRed;
    uint32_t nGreen;
    uint32_t nBlue;
    uint32_t nAlpha;
    uint32_t nPixel;
    
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    {
        nPixel = *pCurPtr;
        nRed = (nPixel & 0xff000000) >> 24;
        nGreen = (nPixel & 0x00FF0000) >> 16;
        nBlue = (nPixel & 0x0000FF00) >> 8;
        nAlpha = nPixel & 0x000000FF;
        
        if ((nPixel & 0xFF) != 0)//非透明区域变为变色
        {
            *pCurPtr = 0xFFFFFFFF;
        }
    }
    // 分配内存
    size_t bitmapBytesPerRow = CGImageGetBytesPerRow(image.CGImage);
    size_t bitsPerComponent = CGImageGetBitsPerComponent(image.CGImage);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(image.CGImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bitmapBytesPerRow * imagePixelHeight,nil);
    CGImageRef imageRef = CGImageCreate(imagePixelWidth, imagePixelHeight, bitsPerComponent, bitsPerPixel, bitmapBytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpace);
    
    free(rgbImageBuf);// 创建dataProvider时已提供释放函数，这里不用free
    rgbImageBuf = nil;
    
    return resultUIImage;
}

+ (UIImage*)imageConvertTransparent:(UIImage*)image toColorWithRed:(int)nRed green:(int)nGreen blue:(int)nBlue opacityToTransparent:(BOOL)bReverse
{
    static int nCallNum = 0;
    nCallNum++;
    if (nCallNum == 2)
    {
        nCallNum = 0;
//        [UIImage imageConvertTransparent:image toColorWithRed:nRed green:nGreen blue:nBlue opacityToTransparent:bReverse];
    }
    
    uint32_t *rgbImageBuf = [image copyImagePixelData];
    // 遍历像素
    const size_t imagePixelWidth = CGImageGetWidth(image.CGImage);
    const size_t imagePixelHeight = CGImageGetHeight(image.CGImage);
    size_t pixelNum = imagePixelWidth * imagePixelHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    
    uint32_t nPixel;
    uint32_t nPixelColorValue = 0xFF;
    nPixelColorValue |= ((nRed & 0xFF) << 24);
    nPixelColorValue |= ((nGreen & 0xFF) << 16);
    nPixelColorValue |= ((nBlue & 0xFF) << 8);
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    {
        nPixel = *pCurPtr;
        if ((nPixel & 0xFF) == 0)//透明区域变为变色
        {
            *pCurPtr = nPixelColorValue;
        }
        else if (bReverse)
        {
            *pCurPtr = 0x00;
        }
    }
    // 分配内存
    size_t bitmapBytesPerRow = CGImageGetBytesPerRow(image.CGImage);
    size_t bitsPerComponent = CGImageGetBitsPerComponent(image.CGImage);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(image.CGImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bitmapBytesPerRow * imagePixelHeight,nil);
    CGImageRef imageRef = CGImageCreate(imagePixelWidth, imagePixelHeight, bitsPerComponent, bitsPerPixel, bitmapBytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    CGColorSpaceRelease(colorSpace);
    
    free(rgbImageBuf);// 创建dataProvider时已提供释放函数，这里不用free
    rgbImageBuf = nil;
    
    return resultUIImage;
}

/** 颜色变化 */
void ProviderReleaseData (void *info, const void *data, size_t size)
{
    free((void*)data);
}

#pragma mark - thumb image
/*
 *  @brief: 将图片输出指定大小
 */
- (UIImage *)outputImageWithSize:(CGSize)size
{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:self];
    CGRect frame = CGRectZero;
    frame.size = size;
    imgV.frame = frame;
    
    UIGraphicsBeginImageContextWithOptions(imgV.bounds.size, NO, 1);
    if (@available(iOS 7.0, *))
    {
        [imgV drawViewHierarchyInRect:imgV.bounds afterScreenUpdates:YES];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
/*
 *  @brief: 将图片按指定缩放比例输出
 */
- (UIImage *)outputImageWithScale:(CGFloat)scaleRatio
{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:self];
    CGRect frame = CGRectZero;
    frame.size.width = self.size.width * scaleRatio;
    frame.size.height = self.size.height * scaleRatio;
    imgV.frame = frame;
    
    UIGraphicsBeginImageContextWithOptions(imgV.bounds.size, NO, 1);
    if (@available(iOS 7.0, *))
        [imgV drawViewHierarchyInRect:imgV.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
/*
 *  @brief: 将图片按指定大小输出圆形图片
 */
- (UIImage *)outputCircleImageWithWidth:(CGFloat)fWidth
{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:self];
    CGRect frame = CGRectZero;
    frame.size.width = fWidth;
    frame.size.height = fWidth;
    imgV.frame = frame;
    imgV.layer.masksToBounds = YES;
    imgV.layer.cornerRadius = frame.size.width / 2;
    
    UIGraphicsBeginImageContextWithOptions(imgV.bounds.size, NO, 1);
    if (@available(iOS 7.0, *))
        [imgV drawViewHierarchyInRect:imgV.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
/*
 *  @brief: 将图片输出自定大小
 */
- (UIImage *)outputCircleImageWithScale:(CGFloat)scaleRatio
{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:self];
    CGRect frame = CGRectZero;
    frame.size.width = self.size.width * scaleRatio;
    frame.size.height = frame.size.width;
    imgV.frame = frame;
    imgV.layer.masksToBounds = YES;
    imgV.layer.cornerRadius = frame.size.width / 2;
    
    UIGraphicsBeginImageContextWithOptions(imgV.bounds.size, NO, 1);
    if (@available(iOS 7.0, *))
        [imgV drawViewHierarchyInRect:imgV.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)outputImageWithMaxSize:(CGSize)size
{
    if (self.size.width <= 0 || self.size.height <= 0)
        return self;
    UIImageView *imgV = [[UIImageView alloc] initWithImage:self];
    CGRect frame = CGRectZero;
    frame.size = size;
    CGFloat fWByHRatio = self.size.width / self.size.height;
    if (frame.size.width > frame.size.height * fWByHRatio)
    {
        frame.size.width = frame.size.height * fWByHRatio;
    }
    else
    {
        frame.size.height = frame.size.width / fWByHRatio;
    }
    imgV.frame = frame;
    
    UIGraphicsBeginImageContextWithOptions(imgV.bounds.size, NO, 1);
    if (@available(iOS 7.0, *))
        [imgV drawViewHierarchyInRect:imgV.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - crop image

- (UIImage *)cropImageWithRect:(CGRect)frame
{
    if (self.size.width <= 0 || self.size.height <= 0)
        return self;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:self];
    [view addSubview:imgV];
    imgV.frame = CGRectMake(-frame.origin.x, -frame.origin.y, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1);
    if (@available(iOS 7.0, *))
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
