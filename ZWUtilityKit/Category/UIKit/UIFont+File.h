//
//  UIFont+File.h
//  DIY
//
//  Created by chenzw on 15/10/29.
//  Copyright © 2015年 BiggerSister. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (File)

/*
 *  @brief：加载指定路径下的字体文件
 *  @param：
 *      strPath：字体文件路径
 *  @ret：加载的字体名称 fontName
 */
+ (NSString *)loadFontFile:(NSString *)strFilePath;

@end