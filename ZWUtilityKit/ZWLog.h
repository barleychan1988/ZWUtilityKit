//
//  ZWLog.h
//
//  Created by 陈正旺 on 14-4-22.
//  Copyright (c) 2014年 chenzhengwang. All rights reserved.
//


/* ------------------------------------------------------
 *
 * @description：写日志文件,以当天的日期为文件名
 *  以Debug开头的方法表示在Debug下才会执行的方法；
 *
 * @update time: 2014-12-17
 *
 * ------------------------------------------------------*/

#import <Foundation/Foundation.h>

@interface ZWLog : NSObject

+ (ZWLog *)logInstance;
- (void)releaseInstance;

//保留uDaysFileRemain天以内的日志文件，default:10
@property (nonatomic, assign)uint uDaysFileRemain;
@property (nonatomic, assign)BOOL bToDebug;//该标志表示在调试窗口也输出日志，default:NO
@property (nonatomic, assign)BOOL bToFile;//日志输出到文件标志，default:YES
@property (nonatomic, copy, readonly)NSString *strFilePath;//日志文件路径

+ (void)writeLogWithSystemInfo;
+ (void)writeLogWithAppInfo;
+ (void)writeString:(NSString *)strLog;
+ (void)writeArray:(NSArray *)arrayLog;
+ (void)writeDictionary:(NSDictionary *)dicLog;
+ (void)writeLogWithParams:(id)param0, ...;
+ (void)writeANSSIString:(char *)strLog;
+ (void)writeLaunchLog:(NSDictionary *)launchOptions;
/*
 *  @brief:获取设备信息写入日志文件
 */
- (void)writeLogWithSystemInfo;
/*
 *  @brief:获取应用信息写入日志文件。
 *  写入的信息有：
 *      名称：如“My Iphone"
 *
 */
- (void)writeLogWithAppInfo;
/*
 *  @description:将strLog加上日期时间写入日志文件尾部并换行
 */
- (void)writeString:(NSString *)strLog;
- (void)writeArray:(NSArray *)arrayLog;
- (void)writeDictionary:(NSDictionary *)dicLog;
/*
 *  @description:将参数列表的值输出到日志文件中, 最后一个参数一定要为nil，其他参数必须
 *      都是对象
 */
- (void)writeLogWithParams:(id)param0, ...;
- (void)writeANSSIString:(char *)strLog;

/*
 *  @description:APP启动调用，输出启动参数到日志文件
 *
 */
- (void)writeLaunchLog:(NSDictionary *)launchOptions;

#ifdef DEBUG
    #define DebugLog(...)    NSLog(__VA_ARGS__)
    #define DLog(...)    NSLog(__VA_ARGS__)
    #define ZWDebugWriteString(param) [[ZWLog logInstance] writeString:param]
    #define ZWDebugWriteArray(param) [[ZWLog logInstance] writeArray:param]
    #define ZWDebugWriteDictionary(param) [[ZWLog logInstance] writeDictionary:param]
    #define ZWDebugWriteLogParams(...) [[ZWLog logInstance] writeLogWithParams:__VA_ARGS__]
#else
    #define DebugLog(...)    /**/
    #define DLog(...)    /**/
    #define ZWDebugWriteString(param) /**/
    #define ZWDebugWriteArray(param) /**/
    #define ZWDebugWriteDictionary(param) /**/
    #define ZWDebugWriteLogParams(...) /**/
#endif

@end
//NSLog(@"%@", NSStringFromSelector(_cmd));

//#pragma mark - 邮件反馈
///*
// *  @brief:设置发送邮件的地址和标题
// *  @pram:strMailAddr,报告地址,若为nil,则采用默认
// *      strSubject,报告邮件标题,若为nil,则采用默认
// */
//void setReportMail(NSString *strMailAddr, NSString *strSubject);
///*
// *  @brief:恢复默认邮件地址和标题
// */
//void defaultReportMailInfo();
///*
// *  @brief:App 崩溃捕捉方法。需在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions中
// *  调用NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
// */
//void UncaughtExceptionHandler(NSException *exception);
///*
// *  @brief:手动发送邮件到反馈地址
// *  @pram:strSubject,报告邮件标题,若为nil,则采用默认
// *      strMailContents,邮件内容
// *      mailComposeDelegate,发送邮件代理,必须是UIViewController实例
// */
//void sendReportMail(NSString *strSubject, NSString *strMailContents, id<MFMailComposeViewControllerDelegate> mailComposeDelegate);
//
///*
//- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
//{
//    
//    NSString *msg;
//    
//    switch (result)
//    {
//        case MFMailComposeResultCancelled:
//            msg = @"邮件发送取消";
//            break;
//        case MFMailComposeResultSaved:
//            msg = @"邮件保存成功";
//            [self alertWithTitle:nil msg:msg];
//            break;
//        case MFMailComposeResultSent:
//            msg = @"邮件发送成功";
//            [self alertWithTitle:nil msg:msg];
//            break;
//        case MFMailComposeResultFailed:
//            msg = @"邮件发送失败";
//            [self alertWithTitle:nil msg:msg];
//            break;
//        default:
//            break;
//    }
//    
//    [self dismissModalViewControllerAnimated:YES];
//}
//*/