//
//  UtilityKit.m
//  checkCar
//
//  Created by chenzhengwang on 14-6-12.
//  Copyright (c) 2014年 zwchen. All rights reserved.
//

#import "UtilityKit.h"
#import <sys/mount.h>
#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import "ZWLog.h"
//#import "Reachability.h"
#import "ZWMacroDef.h"

long long getFreeSpaceInKB()
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    struct statfs tStats;
//    statfs([[paths lastObject] cString], &tStats);
    statfs("/var", &tStats);
    
    long long totalSpace = (long long)(tStats.f_bfree * tStats.f_bsize);
    
    return totalSpace / 1024;
}

NSString *getSafeString(NSString *str)
{
    if ([str isKindOfClass:[NSNull class]])
    {
        return @"";
    }    
    return str;
}

NSString *stringForBool(BOOL bValue)
{
    if (bValue)
        return @"YES";
    else
        return @"NO";
}

NSString *stringForDate(NSDate *date, NSString *strDateFormat)
{
    if (date == nil)
        return @"";
    if (strDateFormat.length == 0)
        strDateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    fmtDate.dateFormat = strDateFormat;
    return [fmtDate stringFromDate:date];
}

NSDate *dateFromString(NSString *strDate)
{
    if (strDate.length == 0)
        return nil;
    NSString *strFmt = @"yyyy-MM-dd HH:mm:ss";
    NSString *strDateFormat;
    if (strDate.length > strFmt.length)
        strDateFormat = strFmt;
    else
        strDateFormat = [strFmt substringToIndex:strDate.length - 1];
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    fmtDate.dateFormat = strDateFormat;
    return [fmtDate dateFromString:strDate];
}

NSDate *dateFromStringWithFormate(NSString *strDate, NSString *strDateFormat)
{
    if (strDate.length == 0)
        return nil;
    if (strDateFormat.length == 0)
        return nil;
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    fmtDate.dateFormat = strDateFormat;
    return [fmtDate dateFromString:strDate];
}

UInt32 strVersionToIntVersion(NSString *strVersion)
{
    NSArray *arrayComponentVersion = [strVersion componentsSeparatedByString:@"."];
    NSString *strVerNum;
    UInt32 unVersion = 0;
    NSInteger nCount = arrayComponentVersion.count;
    if (nCount > 7) nCount = 7;
    for (int i = 0; i < nCount; i++)
    {
        unVersion *= 100;
        
        strVerNum = [arrayComponentVersion objectAtIndex:i];
        unVersion += [strVerNum intValue];
    }
    return unVersion;
}

/*
 *  @brief: 获取设备型号
 */
EnDEVICETYPE getDeviceType()
{
    EnDEVICETYPE ret = DEVICE_UNKNOWN;
    switch (getDeviceTypeDetail())
    {
        //iPhone
        case DEVICE_DETAIL_iPhone:
            ret = DEVICE_iPhone;
            break;
        case DEVICE_DETAIL_iPhone_3G:
            ret = DEVICE_iPhone_3G;
            break;
        case DEVICE_DETAIL_iPhone_3GS:
            ret = DEVICE_iPhone_3GS;
            break;
        case DEVICE_DETAIL_iPhone_4_GSM:
        case DEVICE_DETAIL_iPhone_4_CDMA:
        case DEVICE_DETAIL_iPhone_4_2012:
            ret = DEVICE_iPhone_4;
            break;
        case DEVICE_DETAIL_iPhone_4S:
            ret = DEVICE_iPhone_4S;
            break;
        case DEVICE_DETAIL_iPhone_5:
        case DEVICE_DETAIL_iPhone_5_GSM:
            ret = DEVICE_iPhone_5;
            break;
        case DEVICE_DETAIL_iPhone_5C:
        case DEVICE_DETAIL_iPhone_5C_GSM:
            ret = DEVICE_iPhone_5C;
            break;
        case DEVICE_DETAIL_iPhone_5S:
        case DEVICE_DETAIL_iPhone_5S_GSM:
            ret = DEVICE_iPhone_5S;
            break;
        case DEVICE_DETAIL_iPhone_6:
            ret = DEVICE_iPhone_6;
            break;
        case DEVICE_DETAIL_iPhone_6_Plus:
            ret = DEVICE_iPhone_6_Plus;
            break;
        case DEVICE_DETAIL_iPhone_6S_Plus:
            ret = DEVICE_iPhone_6S_Plus;
            break;
        case DEVICE_DETAIL_iPhone_6S:
            ret = DEVICE_iPhone_6S;
            break;
        //iPod
        case DEVICE_DETAIL_iPod_Touch:
            ret = DEVICE_iPod_Touch;
            break;
        case DEVICE_DETAIL_iPod_Touch_2:
            ret = DEVICE_iPod_Touch_2;
            break;
        case DEVICE_DETAIL_iPod_Touch_3:
            ret = DEVICE_iPod_Touch_3;
            break;
        case DEVICE_DETAIL_iPod_Touch_4:
            ret = DEVICE_iPod_Touch_4;
            break;
        case DEVICE_DETAIL_iPod_Touch_5:
            ret = DEVICE_iPod_Touch_5;
            break;
        //iPad
        case DEVICE_DETAIL_iPad:
            ret = DEVICE_iPad;
            break;
        case DEVICE_DETAIL_iPad_2_Wifi:
        case DEVICE_DETAIL_iPad_2_GSM:
        case DEVICE_DETAIL_iPad_2_CDMA:
        case DEVICE_DETAIL_iPad_2_2013:
            ret = DEVICE_iPad_2;
            break;
        case DEVICE_DETAIL_iPad_mini_Wifi:
        case DEVICE_DETAIL_iPad_mini_GSM:
        case DEVICE_DETAIL_iPad_mini_CDMA:
            ret = DEVICE_iPad_mini;
            break;
        case DEVICE_DETAIL_iPad_3_Wifi:
        case DEVICE_DETAIL_iPad_3_GSM:
        case DEVICE_DETAIL_iPad_3_CDMA:
            ret = DEVICE_iPad_3;
            break;
        case DEVICE_DETAIL_iPad_4_Wifi:
        case DEVICE_DETAIL_iPad_4_GSM:
        case DEVICE_DETAIL_iPad_4_CDMA:
            ret = DEVICE_iPad_4;
            break;
        case DEVICE_DETAIL_iPad_Air_Wifi:
        case DEVICE_DETAIL_iPad_Air_4G:
            ret = DEVICE_iPad_Air;
            break;
        case DEVICE_DETAIL_iPad_mini_2_Wifi:
        case DEVICE_DETAIL_iPad_mini_2_4G:
        case DEVICE_DETAIL_iPad_mini_2_4G_Mobile:
            ret = DEVICE_iPad_mini_2;
            break;
        case DEVICE_DETAIL_iPad_mini_3_Wifi:
        case DEVICE_DETAIL_iPad_mini_3_4G:
        case DEVICE_DETAIL_iPad_mini_3_4G_Mobile:
            ret = DEVICE_iPad_mini_3;
            break;
        case DEVICE_DETAIL_iPad_Air_2_Wifi:
        case DEVICE_DETAIL_iPad_Air_2_4G:
            ret = DEVICE_iPad_Air_2;
            break;
        default:
            break;
    }
    return ret;
}
/*
 *  @brief: 获取设备详细型号
 */
EnDEVICETYPE_DETAIL getDeviceTypeDetail()
{
    EnDEVICETYPE_DETAIL ret = DEVICE_DETAIL_UNKNOWN;
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *strDevice = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([strDevice isEqualToString:@"iPhone1,1"])
        ret = DEVICE_DETAIL_iPhone;
    else if ([strDevice isEqualToString:@"iPhone1,2"])
        ret = DEVICE_DETAIL_iPhone_3G;
    else if ([strDevice isEqualToString:@"iPhone2,1"])
        ret = DEVICE_DETAIL_iPhone_3GS;
    else if ([strDevice isEqualToString:@"iPhone3,1"])//GSM
        ret = DEVICE_DETAIL_iPhone_4_GSM;
    else if ([strDevice isEqualToString:@"iPhone3,2"])//2012新款
        ret = DEVICE_DETAIL_iPhone_4_2012;
    else if ([strDevice isEqualToString:@"iPhone3,3"])//电信CDMA
        ret = DEVICE_DETAIL_iPhone_4_CDMA;
    else if ([strDevice isEqualToString:@"iPhone4,1"])
        ret = DEVICE_DETAIL_iPhone_4S;
    else if ([strDevice isEqualToString:@"iPhone5,1"])//GSM
        ret = DEVICE_DETAIL_iPhone_5_GSM;
    else if ([strDevice isEqualToString:@"iPhone5,2"])//GSM+CDMA
        ret = DEVICE_DETAIL_iPhone_5;
    else if ([strDevice isEqualToString:@"iPhone5,3"])//GSM
        ret = DEVICE_DETAIL_iPhone_5C_GSM;
    else if ([strDevice isEqualToString:@"iPhone5,4"])//GSM+CDMA
        ret = DEVICE_DETAIL_iPhone_5C;
    else if ([strDevice isEqualToString:@"iPhone6,1"])//GSM+CDMA
        ret = DEVICE_DETAIL_iPhone_5S;
    else if ([strDevice isEqualToString:@"iPhone6,2"])//GSM
        ret = DEVICE_DETAIL_iPhone_5S_GSM;
    else if ([strDevice isEqualToString:@"iPhone7,1"])
        ret = DEVICE_DETAIL_iPhone_6_Plus;
    else if ([strDevice isEqualToString:@"iPhone7,2"])
        ret = DEVICE_DETAIL_iPhone_6;
    else if ([strDevice isEqualToString:@"iPhone8,2"])
        ret = DEVICE_DETAIL_iPhone_6S_Plus;
    else if ([strDevice isEqualToString:@"iPhone8,1"])
        ret = DEVICE_DETAIL_iPhone_6S;
    //iPad
    else if ([strDevice isEqualToString:@"iPad1,1"])
        ret = DEVICE_DETAIL_iPad;
    else if ([strDevice isEqualToString:@"iPad2,1"])//Wifi
        ret = DEVICE_DETAIL_iPad_2_Wifi;
    else if ([strDevice isEqualToString:@"iPad2,2"])//GSM
        ret = DEVICE_DETAIL_iPad_2_GSM;
    else if ([strDevice isEqualToString:@"iPad2,3"])//CDMA
        ret = DEVICE_DETAIL_iPad_2_CDMA;
    else if ([strDevice isEqualToString:@"iPad2,4"])//2013新版
        ret = DEVICE_DETAIL_iPad_2_2013;
    else if ([strDevice isEqualToString:@"iPad2,5"])//Wifi
        ret = DEVICE_DETAIL_iPad_mini_Wifi;
    else if ([strDevice isEqualToString:@"iPad2,6"])//CDMA
        ret = DEVICE_DETAIL_iPad_mini_CDMA;
    else if ([strDevice isEqualToString:@"iPad2,7"])//GSM
        ret = DEVICE_DETAIL_iPad_mini_GSM;
    else if ([strDevice isEqualToString:@"iPad3,1"])//Wifi
        ret = DEVICE_DETAIL_iPad_3_Wifi;
    else if ([strDevice isEqualToString:@"iPad3,2"])//CDMA
        ret = DEVICE_DETAIL_iPad_3_CDMA;
    else if ([strDevice isEqualToString:@"iPad3,3"])//GSM
        ret = DEVICE_DETAIL_iPad_3_GSM;
    else if ([strDevice isEqualToString:@"iPad3,4"])//Wifi
        ret = DEVICE_DETAIL_iPad_4_Wifi;
    else if ([strDevice isEqualToString:@"iPad3,5"])//GSM
        ret = DEVICE_DETAIL_iPad_4_GSM;
    else if ([strDevice isEqualToString:@"iPad3,6"])//CDMA
        ret = DEVICE_DETAIL_iPad_4_CDMA;
    else if ([strDevice isEqualToString:@"iPad4,1"])//Wifi
        ret = DEVICE_DETAIL_iPad_Air_Wifi;
    else if ([strDevice isEqualToString:@"iPad4,2"])//4G
        ret = DEVICE_DETAIL_iPad_Air_4G;
    else if ([strDevice isEqualToString:@"iPad4,3"])//4G
        ret = DEVICE_DETAIL_iPad_Air_4GTD;
    else if ([strDevice isEqualToString:@"iPad4,4"])//Wifi
        ret = DEVICE_DETAIL_iPad_mini_2_Wifi;
    else if ([strDevice isEqualToString:@"iPad4,5"])//4G
        ret = DEVICE_DETAIL_iPad_mini_2_4G;
    else if ([strDevice isEqualToString:@"iPad4,6"])//移动4G
        ret = DEVICE_DETAIL_iPad_mini_2_4G_Mobile;
    else if ([strDevice isEqualToString:@"iPad4,7"])//Wifi
        ret = DEVICE_DETAIL_iPad_mini_3_Wifi;
    else if ([strDevice isEqualToString:@"iPad4,8"])//4G
        ret = DEVICE_DETAIL_iPad_mini_3_4G;
    else if ([strDevice isEqualToString:@"iPad4,9"])//移动4G
        ret = DEVICE_DETAIL_iPad_mini_3_4G_Mobile;
    else if ([strDevice isEqualToString:@"iPad5,1"])//Wifi
        ret = DEVICE_DETAIL_iPad_mini_4_Wifi;
    else if ([strDevice isEqualToString:@"iPad5,2"])//4G
        ret = DEVICE_DETAIL_iPad_mini_4_4G;
    else if ([strDevice isEqualToString:@"iPad5,3"])//Wifi
        ret = DEVICE_DETAIL_iPad_Air_2_Wifi;
    else if ([strDevice isEqualToString:@"iPad5,4"])//4G
        ret = DEVICE_DETAIL_iPad_Air_2_4G;
    //iPod
    else if ([strDevice isEqualToString:@"iPod1,1"])
        ret = DEVICE_DETAIL_iPod_Touch;
    else if ([strDevice isEqualToString:@"iPod2,1"])
        ret = DEVICE_DETAIL_iPod_Touch_2;
    else if ([strDevice isEqualToString:@"iPod3,1"])
        ret = DEVICE_DETAIL_iPod_Touch_3;
    else if ([strDevice isEqualToString:@"iPod4,1"])
        ret = DEVICE_DETAIL_iPod_Touch_4;
    else if ([strDevice isEqualToString:@"iPod5,1"])
        ret = DEVICE_DETAIL_iPod_Touch_5;
    else if ([strDevice isEqualToString:@"iPod7,1"])
        ret = DEVICE_DETAIL_iPod_Touch_6;
    
    else if ([strDevice isEqualToString:@"i386"] || [strDevice isEqualToString:@"x86_64"])
        ret = DEVICE_DETAIL_SIMULATOR;
    return ret;
}

NSString * stringForDevice()
{
    NSString *strRet;
    switch (getDeviceTypeDetail())
    {
        //iPhone
        case DEVICE_DETAIL_iPhone:
            strRet = @"iPhone";
            break;
        case DEVICE_DETAIL_iPhone_3G:
            strRet = @"iPhone 3G";
            break;
        case DEVICE_DETAIL_iPhone_3GS:
            strRet = @"iPhone 3GS";
            break;
        case DEVICE_DETAIL_iPhone_4_GSM:
            strRet = @"iPhone 4(GSM)";
            break;
        case DEVICE_DETAIL_iPhone_4_CDMA:
            strRet = @"iPhone 4(CDMA)";
            break;
        case DEVICE_DETAIL_iPhone_4_2012:
            strRet = @"iPhone 4(2012新款)";
            break;
        case DEVICE_DETAIL_iPhone_4S:
            strRet = @"iPhone 4S";
            break;
        case DEVICE_DETAIL_iPhone_5:
            strRet = @"iPhone 5";
            break;
        case DEVICE_DETAIL_iPhone_5_GSM:
            strRet = @"iPhone 5(GSM)";
            break;
        case DEVICE_DETAIL_iPhone_5C:
            strRet = @"iPhone 5C";
            break;
        case DEVICE_DETAIL_iPhone_5C_GSM:
            strRet = @"iPhone 5C(GSM)";
            break;
        case DEVICE_DETAIL_iPhone_5S:
            strRet = @"iPhone 5S";
            break;
        case DEVICE_DETAIL_iPhone_5S_GSM:
            strRet = @"iPhone 5S(GSM)";
            break;
        case DEVICE_DETAIL_iPhone_6:
            strRet = @"iPhone 6";
            break;
        case DEVICE_DETAIL_iPhone_6_Plus:
            strRet = @"iPhone 6Plus";
            break;
        case DEVICE_DETAIL_iPhone_6S_Plus:
            strRet = @"iPhone 6SPlus";
            break;
        case DEVICE_DETAIL_iPhone_6S:
            strRet = @"iPhone 6S";
            break;
        //iPod
        case DEVICE_DETAIL_iPod_Touch:
            strRet = @"iPod Touch";
            break;
        case DEVICE_DETAIL_iPod_Touch_2:
            strRet = @"iPod Touch 2";
            break;
        case DEVICE_DETAIL_iPod_Touch_3:
            strRet = @"iPod Touch 3";
            break;
        case DEVICE_DETAIL_iPod_Touch_4:
            strRet = @"iPod Touch 4";
            break;
        case DEVICE_DETAIL_iPod_Touch_5:
            strRet = @"iPod Touch 5";
            break;
        //iPad
        case DEVICE_DETAIL_iPad:
            strRet = @"iPad";
            break;
        case DEVICE_DETAIL_iPad_2_Wifi:
            strRet = @"iPad 2(Wifi)";
            break;
        case DEVICE_DETAIL_iPad_2_GSM:
            strRet = @"iPad 2(GSM)";
            break;
        case DEVICE_DETAIL_iPad_2_CDMA:
            strRet = @"iPad 2(CDMA)";
            break;
        case DEVICE_DETAIL_iPad_2_2013:
            strRet = @"iPad 2(2013)";
            break;
        case DEVICE_DETAIL_iPad_mini_Wifi:
            strRet = @"iPad mini(Wifi)";
            break;
        case DEVICE_DETAIL_iPad_mini_GSM:
            strRet = @"iPad mini(GSM)";
            break;
        case DEVICE_DETAIL_iPad_mini_CDMA:
            strRet = @"iPad mini(CDMA)";
            break;
        case DEVICE_DETAIL_iPad_3_Wifi:
            strRet = @"iPad 3(Wifi)";
            break;
        case DEVICE_DETAIL_iPad_3_GSM:
            strRet = @"iPad 3(GSM)";
            break;
        case DEVICE_DETAIL_iPad_3_CDMA:
            strRet = @"iPad 3(CDMA)";
            break;
        case DEVICE_DETAIL_iPad_4_Wifi:
            strRet = @"iPad 4(Wifi)";
            break;
        case DEVICE_DETAIL_iPad_4_GSM:
            strRet = @"iPad 4(GSM)";
            break;
        case DEVICE_DETAIL_iPad_4_CDMA:
            strRet = @"iPad 4(CDMA)";
            break;
        case DEVICE_DETAIL_iPad_Air_Wifi:
            strRet = @"iPad Air(Wifi)";
            break;
        case DEVICE_DETAIL_iPad_Air_4G:
            strRet = @"iPad Air(4G)";
            break;
        case DEVICE_DETAIL_iPad_mini_2_Wifi:
            strRet = @"iPad mini 2(Wifi)";
            break;
        case DEVICE_DETAIL_iPad_mini_2_4G:
            strRet = @"iPad mini 2(4G)";
            break;
        case DEVICE_DETAIL_iPad_mini_2_4G_Mobile:
            strRet = @"iPad mini 2(移动4G)";
            break;
        case DEVICE_DETAIL_iPad_mini_3_Wifi:
            strRet = @"iPad mini 3(Wifi)";
            break;
        case DEVICE_DETAIL_iPad_mini_3_4G:
            strRet = @"iPad mini 3(4G)";
            break;
        case DEVICE_DETAIL_iPad_mini_3_4G_Mobile:
            strRet = @"iPad mini 3(移动4G)";
            break;
        case DEVICE_DETAIL_iPad_Air_2_Wifi:
            strRet = @"iPad Air 2(Wifi)";
            break;
        case DEVICE_DETAIL_iPad_Air_2_4G:
            strRet = @"iPad Air 2(4G)";
            break;
        case DEVICE_DETAIL_SIMULATOR:
            strRet = @"模拟器";
            break;
        default:
        {
            struct utsname systemInfo;
            uname(&systemInfo);
            strRet = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        }
            break;
    }
    return strRet;
}

EnDEVICETYPE_SIZE getDeviceTypeSize()
{
    EnDEVICETYPE_SIZE ret = DEVICE_SIZE_UNKNOWN;
    if ([UIScreen instancesRespondToSelector:@selector(currentMode)])
    {
        CGSize sz = [[UIScreen mainScreen] currentMode].size;
        if (CGSizeEqualToSize(CGSizeMake(320, 480), sz))
        {
            ret = DEVICE_SIZE_iPhone_3GS;
        }
        else if (CGSizeEqualToSize(CGSizeMake(640, 960), sz))
        {
            ret = DEVICE_SIZE_iPhone_4;
        }
        else if (CGSizeEqualToSize(CGSizeMake(640, 1136), sz))
        {
            ret = DEVICE_SIZE_iPhone_5;
        }
        else if (CGSizeEqualToSize(CGSizeMake(750, 1334), sz))
        {
            ret = DEVICE_SIZE_iPhone_6;
        }
        else if (CGSizeEqualToSize(CGSizeMake(1242, 2208), sz))
        {
            ret = DEVICE_SIZE_iPhone_6_Plus;
        }
        else if (CGSizeEqualToSize(CGSizeMake(1125, 2436), sz))
        {
            ret = DEVICE_SIZE_iPhone_X;
        }
    }
    return ret;
}

#pragma mark - alert Authorization

void alertNotificationAuthorization()
{
    if (@available(iOS 8.0, *))
    {
        Class a = NSClassFromString(@"UIUserNotificationSettings");
        [[UIApplication sharedApplication] registerUserNotificationSettings:[a
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else//需要证书对于开通通知才可测试弹出确认框
    {
        _Pragma("clang diagnostic push")
        _Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge| UIRemoteNotificationTypeSound| UIRemoteNotificationTypeAlert)];
        _Pragma("clang diagnostic pop")
    }
}

void openAppStore(NSString *strAppID)
{
    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@", strAppID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
