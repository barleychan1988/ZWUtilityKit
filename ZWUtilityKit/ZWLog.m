//
//  ZWLog.m
//
//  Created by 陈正旺 on 14-4-22.
//  Copyright (c) 2014年 chenzhengwang. All rights reserved.
//

#import "ZWLog.h"
#import <UIKit/UIDevice.h>
#import "UtilityKit.h"
#import <UIKit/UIKit.h>
#import "ZWMacroDef.h"

@interface ZWLog()
{
    NSFileHandle *m_handleFile;
    NSString *m_strLogFilePath;//日志文件路径
    
    BOOL m_bToDebug;
    BOOL m_bToFile;
    
    uint m_uLogFileRemainDays;//文件保留的天数    
}
@end

@implementation ZWLog

static ZWLog *zwLog = nil;

+ (ZWLog *)logInstance
{
    @synchronized(self)
    {
        if (zwLog == nil)
        {
            zwLog = [[ZWLog alloc] init];
            [zwLog writeLogWithAppInfo];
        }
    }
    return zwLog;
}

#pragma mark - static method

+ (void)writeLogWithSystemInfo
{
    if (zwLog == nil)
    {
        [ZWLog logInstance];
    }
    else
    {
        BOOL bOldToFile = [ZWLog logInstance].bToFile;
        [ZWLog logInstance].bToFile = NO;
        [[ZWLog logInstance] writeLogWithSystemInfo];
        [ZWLog logInstance].bToFile = bOldToFile;
    }
}
+ (void)writeLogWithAppInfo
{
    if (zwLog == nil)
    {
        [ZWLog logInstance];
    }
    else
    {
        BOOL bOldToFile = [ZWLog logInstance].bToFile;
        [ZWLog logInstance].bToFile = NO;
        [[ZWLog logInstance] writeLogWithAppInfo];
        [ZWLog logInstance].bToFile = bOldToFile;
    }
}
+ (void)writeString:(NSString *)strLog
{
    [[ZWLog logInstance] writeString:strLog];
}
+ (void)writeArray:(NSArray *)arrayLog
{
    [[ZWLog logInstance] writeArray:arrayLog];
}
+ (void)writeDictionary:(NSDictionary *)dicLog
{
    [[ZWLog logInstance] writeDictionary:dicLog];
}
+ (void)writeLogWithParams:(id)param0, ...
{
    if (param0 == nil)
        return;
    NSString *strLogParam = [NSString stringWithFormat:@"%@", param0];
    va_list arguments;
    va_start(arguments, param0);
    id param;
    while ((param = va_arg(arguments, id)))
    {
        strLogParam = [strLogParam stringByAppendingFormat:@" %@", param];
    }
    va_end(arguments);
    
    [[ZWLog logInstance] writeString:strLogParam];
}
+ (void)writeANSSIString:(char *)strLog
{
    [[ZWLog logInstance] writeANSSIString:strLog];
}
+ (void)writeLaunchLog:(NSDictionary *)launchOptions
{
    [[ZWLog logInstance] writeLaunchLog:launchOptions];
}

#pragma mark - 

@synthesize uDaysFileRemain = m_uLogFileRemainDays;
@synthesize bToDebug = m_bToDebug;
@synthesize bToFile = m_bToFile;
@synthesize strFilePath = m_strLogFilePath;

- (id) init
{
    if (self = [super init])
    {
        m_handleFile = NULL;
        m_uLogFileRemainDays = 10;
        m_bToFile = YES;
        m_bToDebug = NO;
        
        //创建并打开文件，文件名为当天的日期，文件位于documents/log/2014-05-03.log
        [self initLogFilePath];
        
        [self deleteFileTenDaysAgo];
        [self createAndOpenLogFile];
    }
    return self;
}

/*
 *  @description: 初始化日志文件路径
 *      ~/Library/Cache/log
 */
- (void)initLogFilePath
{
    NSString *strPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    m_strLogFilePath = [strPath stringByAppendingPathComponent:@"log"];
}

/*
 *  @description:以当前日期为文件名在日志目录下创建日志文件,并打开文件
 *      第一次创建日志文件时会写入设备信息
 *  @ret:YES if create and open successfully，otherwise NO
 */
- (BOOL)createAndOpenLogFile
{
    BOOL bRet = YES;
    //如果log目录不存在则创建
    BOOL bIsDirectory = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:m_strLogFilePath isDirectory:&bIsDirectory])
    {
        if (![fileManager createDirectoryAtPath:m_strLogFilePath withIntermediateDirectories:NO attributes:nil error:nil])
        {
            NSLog(@"create directory %@ error!", m_strLogFilePath);
            bRet = NO;
        }
    }
    //如果文件不存在则创建
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString *strLogFileName = [[formater stringFromDate:[NSDate date]] stringByAppendingString:@".log"];
    NSString *strLogFile = [m_strLogFilePath stringByAppendingPathComponent:strLogFileName];
    BOOL bWriteDeviceInfo = NO;
    if (![fileManager fileExistsAtPath:strLogFile])
    {
        if (![fileManager createFileAtPath:strLogFile contents:nil attributes:nil])
        {
            NSLog(@"create file %@ error!", strLogFile);
            bRet = NO;
        }
        else
        {
            bWriteDeviceInfo = YES;
        }
    }
    //打开文件
    m_handleFile = [NSFileHandle fileHandleForWritingAtPath:strLogFile];
    if (m_handleFile == nil)
    {
        NSLog(@"Open strLogFile file for writing failed!");
        bRet = NO;
    }
    else //打开成功后，指向文件尾
    {
        [m_handleFile seekToEndOfFile];
        if (bWriteDeviceInfo)   //由于设备信息只写入一次，故放在此处
        {
            [self writeLogWithSystemInfo];
        }
    }
    return bRet;
}

/*
 *  @description:删除~/document/log/目录下10天前的日志文件
 */
- (void)deleteFileTenDaysAgo
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *arrayLogFileList = [[fileManager contentsOfDirectoryAtPath:m_strLogFilePath error:nil]
                         pathsMatchingExtensions:[NSArray arrayWithObject:@"log"]] ;
    
    NSString *strLogFileName;
    NSString *strLogFileDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * dateLogFile;
    NSTimeInterval dbTimeDiff = m_uLogFileRemainDays * 86400; //m_uLogFileRemainDays*24*60*60 s
    for (NSString * file in arrayLogFileList)
    {
        strLogFileName = [m_strLogFilePath stringByAppendingPathComponent:file];
        strLogFileDate = [file stringByDeletingPathExtension];
        dateLogFile = [dateFormatter dateFromString:strLogFileDate];
        if ([dateLogFile timeIntervalSinceNow] > dbTimeDiff) //m_uLogFileRemainDays天前的日志清楚
        {
            if (![fileManager removeItemAtPath:strLogFileName error:nil])
                NSLog(@"remove file %@ error!", strLogFileName);
        }
    }
}

- (void)releaseInstance
{
    zwLog = nil;
}

- (void)dealloc
{
    [m_handleFile closeFile];
    m_handleFile = nil;
}

#pragma mark - common

/*
 *  @brief:获取设备信息写入日志文件。
 *  写入的信息有：
 *      名称：如“My Iphone"
 *
 */
- (void)writeLogWithSystemInfo
{
    UIDevice *device = [UIDevice currentDevice];
    [self writeLogWithParams:@"\n\t-------- 设备信息 --------",
                             @"\n\tPhone Type:",stringForDevice(),
                             @"\n\tname:", device.name,
//                             @"\n\tmodel:", device.model,
                             @"\n\tlocalized version of model:", device.localizedModel,
                             @"\n\tsystem name:", device.systemName,
                             @"\n\tsystem version:", device.systemVersion,
                            nil];
}

/*
 *  @brief:获取应用信息写入日志文件。
 *  写入的信息有：
 *      名称：如“路精灵"
 *
 */
- (void)writeLogWithAppInfo
{
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
//    NSString *strAppName = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey];
    NSString *strAppDisplayName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    NSString *strCurVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *strBundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
    NSString *strBuildVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    UIApplication *app = [UIApplication sharedApplication];
    BOOL bEnableRemoteNotification;
    if (@available(iOS 8.0, *))
    {
        bEnableRemoteNotification = [app isRegisteredForRemoteNotifications];
    }
    else
    {
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
        if (UIRemoteNotificationTypeNone == [app enabledRemoteNotificationTypes])
            bEnableRemoteNotification = NO;
        else
            bEnableRemoteNotification = YES;
       _Pragma("clang diagnostic pop")
    }
    [self writeLogWithParams:@"\n\t-------- 应用信息 --------",
     @"\n\tApp Name:",strAppDisplayName,
     @"\n\tBundle ID:", strBundleID,
     @"\n\tVersion:", strCurVersion,
     @"\n\tBuild version:", strBuildVersion,
     [NSString stringWithFormat:@"\n\tbattery Level:%.2f%%", device.batteryLevel * 100],
     //通知开关
     [NSString stringWithFormat:@"\n\tRemote Notification enable:%@", stringForBool(bEnableRemoteNotification)],
     nil];
    device.batteryMonitoringEnabled = NO;
}

- (void)writeString:(NSString *)strLog
{
    if ([strLog length] <= 0)
        return;
    
    if (m_bToDebug)
        DLog(@"%@", strLog);
    
    if (m_bToFile)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss "];
        strLog = [[dateFormatter stringFromDate:[NSDate date]] stringByAppendingFormat:@"%@\n", strLog];
        
        NSData *data = [strLog dataUsingEncoding:NSUTF8StringEncoding];
        [m_handleFile writeData:data];
    }
}

- (void)writeArray:(NSArray *)arrayLog
{
    if ([arrayLog count] <= 0)
        return;
    NSString *strLog = [NSString stringWithFormat:@"array=%@", arrayLog];
    [self writeString:strLog];
}

- (void)writeDictionary:(NSDictionary *)dicLog
{
    if ([dicLog count] <= 0)
        return;
    
    NSString *strLog = [NSString stringWithFormat:@"dictionary=%@", dicLog];
    [self writeString:strLog];
}

- (void)writeLogWithParams:(id)param0, ...
{
    if (param0 == nil)
        return;
    NSString *strLogParam = [NSString stringWithFormat:@"%@", param0];
    va_list arguments;
    va_start(arguments, param0);
    id param;
    while ((param = va_arg(arguments, id)))
    {
        strLogParam = [strLogParam stringByAppendingFormat:@" %@", param];
    }
    va_end(arguments);
    
    [self writeString:strLogParam];
}

- (void)writeANSSIString:(char *)strLog
{
    NSString *str=[NSString stringWithCString:strLog encoding:NSUTF8StringEncoding];
    [self writeString:str];
}

#pragma mark - s

- (void)writeLaunchLog:(NSDictionary *)launchOptions
{
    NSString *strAppName = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey];
    [self writeLogWithParams:@"------------ Application ", strAppName, @" launched ------------\n", @"launch options = ", launchOptions, nil];
}

+ (NSString *)logText
{
    ZWLog *log = [ZWLog logInstance];
    NSString *strPath = log->m_strLogFilePath;
    strPath = [strPath stringByAppendingFormat:@"/%@.log", stringForDate([NSDate date], @"YYYY-MM-dd")];
    NSString *str = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    return str;
}

@end
//
//#pragma mark - bug mail report
//
//static NSString *g_strMailAddr = @"swrd@wisdom-gps.com";
//static NSString *g_strMailSubject = @"iOS App bug报告";
//
//void setReportMail(NSString *strMailAddr, NSString *strSubject)
//{
//    if ([strMailAddr length] > 0)
//    {
//        g_strMailAddr = strMailAddr;
//    }
//    if ([strSubject length] > 0)
//    {
//        g_strMailSubject = strSubject;
//    }
//}
//
//void defaultReportMailInfo()
//{
//    g_strMailAddr = @"swrd@wisdom-gps.com";
//    g_strMailSubject = @"iOS App bug报告";
//}
//
//void UncaughtExceptionHandler(NSException *exception)
//{
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    [def setBool:YES forKey:@"exception"];
//    [def synchronize];
//    
//    NSArray *arr = [exception callStackSymbols];
//    NSString *reason = [exception reason];
//    NSString *name = [exception name];
//    
//    NSString *urlStr = [NSString stringWithFormat:@"mailto://%@?subject=%@&body=<br><br>" "%@<br>--------------------------<br>%@<br>--------------------------<br>%@", g_strMailAddr, g_strMailSubject, name, reason,[arr componentsJoinedByString:@"<br>"]];
//    
////    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
////    [[UIApplication sharedApplication] openURL:url];
//    
//    NSString *strCrashMsg = [NSString stringWithFormat:@"%@\n--------------------------\n%@\n--------------------------\n%@", name, reason, [arr componentsJoinedByString:@"\n"]];
//    [[ZWLog logInstance] writeString:strCrashMsg];
//}
//
//void sendReportMail(NSString *strSubject, NSString *strMailContents, id<MFMailComposeViewControllerDelegate> mailComposeDelegate)
//{
//    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
//    [formater setDateFormat:@"yyyy-MM-dd"];
//    NSString *strFileName = [[formater stringFromDate:[NSDate date]] stringByAppendingPathExtension:@"log"];
//    NSString *strLogFile = [[ZWLog logInstance].strFilePath stringByAppendingFormat:@"/%@", strFileName];
//    
//    NSString *logData = [[NSString alloc] initWithContentsOfFile:strLogFile encoding:NSUTF8StringEncoding error:nil];
//    if (logData)
//    {
//        MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
//        if(mailCompose)
//        {
//            //设置代理
//            [mailCompose setMailComposeDelegate:mailComposeDelegate];
//            
//            NSArray *arrayToAddress = [NSArray arrayWithObject:g_strMailAddr];
//            NSString *emailBody = @"<H1>日志信息</H1>";
//            
//            //设置收件人
//            [mailCompose setToRecipients:arrayToAddress];
//            //设置抄送人
//            //            [mailCompose setCcRecipients:arrayCCAddress];
//            //设置邮件内容
//            [mailCompose setMessageBody:emailBody isHTML:YES];
//            
//            NSData* pData = [[NSData alloc] initWithContentsOfFile:strLogFile];
//            
//            //设置邮件主题
//            [mailCompose setSubject:g_strMailSubject];
//            //设置邮件附件{mimeType:文件格式|fileName:文件名}
//            [mailCompose addAttachmentData:pData mimeType:@"txt" fileName:@"日志.txt"];
//            //设置邮件视图在当前视图上显示方式
//            [((UIViewController *)mailComposeDelegate) presentViewController:mailCompose animated:YES completion:nil];
//        }
//    }
//}
