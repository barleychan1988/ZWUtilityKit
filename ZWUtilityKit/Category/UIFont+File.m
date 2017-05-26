//
//  UIFont+File.m
//  DIY
//
//  Created by chenzw on 15/10/29.
//  Copyright © 2015年 BiggerSister. All rights reserved.
//

#import "UIFont+File.h"
#import <CoreText/CoreText.h>

@implementation UIFont (File)

+ (NSString *)loadFontFile:(NSString *)strFilePath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL bIsDirectory = NO;
    BOOL bIsExist = [fm fileExistsAtPath:strFilePath isDirectory:&bIsDirectory];
    if (!bIsExist || bIsDirectory)
        return nil;
    
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithFilename([strFilePath UTF8String]);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    CGFontRelease(fontRef);
    return fontName;
}
@end