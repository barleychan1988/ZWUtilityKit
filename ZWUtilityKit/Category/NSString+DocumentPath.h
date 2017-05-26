//
//  NSString+DocumentPath.h
//  气泡
//
//  Created by zzy on 14-5-15.
//  Update by zwchen on 15.10.28
//  Copyright (c) 2014年 zzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DocumentPath)

//返回“Documents”目录下的制定文件或目录的全路径
+ (NSString *)documentPathWith:(NSString *)fileName;

//返回“Library”目录下的制定文件或目录的全路径
+ (NSString *)libraryPathWith:(NSString *)fileName;

//返回“tmp”目录下的制定文件或目录的全路径
+ (NSString *)tmpPathWith:(NSString *)fileName;

//返回删除代表倍数的部分，如“test@2x.png",返回@”test.png"
- (NSString *)stringByDeletingScaleType;

- (NSString *)stringByDeletingIconType;

@end