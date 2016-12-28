//
//  UtilityKit.h
//  checkCar
//
//  Created by chenzhengwang on 14-6-12.
//  Copyright (c) 2014年 zwchen. All rights reserved.
//

/* ------------------------------------------------------
 *
 * @description：
 *
 * @update time: 2014-12-15
 *
 * ------------------------------------------------------*/
#import <Foundation/Foundation.h>

/*
 *  @brief: 获取设备型号
 */
typedef enum tagEnumDeviceType
{
    //iPhone
    DEVICE_iPhone = 0,
    DEVICE_iPhone_3G,
    DEVICE_iPhone_3GS,
    DEVICE_iPhone_4,
    DEVICE_iPhone_4S,
    DEVICE_iPhone_5,
    DEVICE_iPhone_5C,
    DEVICE_iPhone_5S,
    DEVICE_iPhone_6,
    DEVICE_iPhone_6_Plus,
    DEVICE_iPhone_6S,
    DEVICE_iPhone_6S_Plus,
    //iPod
    DEVICE_iPod_Touch,
    DEVICE_iPod_Touch_2,
    DEVICE_iPod_Touch_3,
    DEVICE_iPod_Touch_4,
    DEVICE_iPod_Touch_5,
    //iPad
    DEVICE_iPad,
    DEVICE_iPad_2,
    DEVICE_iPad_mini,
    DEVICE_iPad_3,
    DEVICE_iPad_4,
    DEVICE_iPad_Air,
    DEVICE_iPad_mini_2,
    DEVICE_iPad_mini_3,
    DEVICE_iPad_Air_2,
    DEVICE_SIMULATOR,
    DEVICE_UNKNOWN
}EnDEVICETYPE;

EnDEVICETYPE getDeviceType();
/*
 *  @brief: 获取设备详细型号
 */
typedef enum tagEnumDeviceTypeDetail
{
    //iPhone
    DEVICE_DETAIL_iPhone = 0,
    DEVICE_DETAIL_iPhone_3G,
    DEVICE_DETAIL_iPhone_3GS,
    DEVICE_DETAIL_iPhone_4_GSM,
    DEVICE_DETAIL_iPhone_4_CDMA,
    DEVICE_DETAIL_iPhone_4_2012,
    DEVICE_DETAIL_iPhone_4S,
    DEVICE_DETAIL_iPhone_5,
    DEVICE_DETAIL_iPhone_5_GSM,
    DEVICE_DETAIL_iPhone_5C,
    DEVICE_DETAIL_iPhone_5C_GSM,
    DEVICE_DETAIL_iPhone_5S,
    DEVICE_DETAIL_iPhone_5S_GSM,
    DEVICE_DETAIL_iPhone_6,
    DEVICE_DETAIL_iPhone_6_Plus,
    DEVICE_DETAIL_iPhone_6S,
    DEVICE_DETAIL_iPhone_6S_Plus,
    //iPod
    DEVICE_DETAIL_iPod_Touch,
    DEVICE_DETAIL_iPod_Touch_2,
    DEVICE_DETAIL_iPod_Touch_3,
    DEVICE_DETAIL_iPod_Touch_4,
    DEVICE_DETAIL_iPod_Touch_5,
    DEVICE_DETAIL_iPod_Touch_6,
    //iPad
    DEVICE_DETAIL_iPad,
    DEVICE_DETAIL_iPad_2_Wifi,
    DEVICE_DETAIL_iPad_2_GSM,
    DEVICE_DETAIL_iPad_2_CDMA,
    DEVICE_DETAIL_iPad_2_2013,
    DEVICE_DETAIL_iPad_mini_Wifi,
    DEVICE_DETAIL_iPad_mini_GSM,
    DEVICE_DETAIL_iPad_mini_CDMA,
    DEVICE_DETAIL_iPad_3_Wifi,
    DEVICE_DETAIL_iPad_3_GSM,
    DEVICE_DETAIL_iPad_3_CDMA,
    DEVICE_DETAIL_iPad_4_Wifi,
    DEVICE_DETAIL_iPad_4_GSM,
    DEVICE_DETAIL_iPad_4_CDMA,
    DEVICE_DETAIL_iPad_Air_Wifi,
    DEVICE_DETAIL_iPad_Air_4G,
    DEVICE_DETAIL_iPad_Air_4GTD,
    DEVICE_DETAIL_iPad_mini_2_Wifi,
    DEVICE_DETAIL_iPad_mini_2_4G,
    DEVICE_DETAIL_iPad_mini_2_4G_Mobile,
    DEVICE_DETAIL_iPad_mini_3_Wifi,
    DEVICE_DETAIL_iPad_mini_3_4G,
    DEVICE_DETAIL_iPad_mini_3_4G_Mobile,
    DEVICE_DETAIL_iPad_mini_4_Wifi,
    DEVICE_DETAIL_iPad_mini_4_4G,
    DEVICE_DETAIL_iPad_Air_2_Wifi,
    DEVICE_DETAIL_iPad_Air_2_4G,
    
    DEVICE_DETAIL_SIMULATOR,
    DEVICE_DETAIL_UNKNOWN
}EnDEVICETYPE_DETAIL;

EnDEVICETYPE_DETAIL getDeviceTypeDetail();

/*
 *  @brief: 获取设备类型，按屏幕大小分类
 */
typedef enum tagEnumDeviceTypeSize
{
    //iPhone
    DEVICE_SIZE_iPhone = 0,
    DEVICE_SIZE_iPhone_3GS,
    DEVICE_SIZE_iPhone_4,
    DEVICE_SIZE_iPhone_5,
    DEVICE_SIZE_iPhone_6,
    DEVICE_SIZE_iPhone_6_Plus,
    //iPod
    DEVICE_SIZE_iPod_Touch,
    DEVICE_SIZE_iPod_Touch_2,
    DEVICE_SIZE_iPod_Touch_3,
    DEVICE_SIZE_iPod_Touch_4,
    DEVICE_SIZE_iPod_Touch_5,
    //iPad
    DEVICE_SIZE_iPad,
    DEVICE_SIZE_iPad_2_Wifi,
    DEVICE_SIZE_iPad_2_GSM,
    DEVICE_SIZE_iPad_2_CDMA,
    DEVICE_SIZE_iPad_2_2013,
    DEVICE_SIZE_iPad_mini_Wifi,
    DEVICE_SIZE_iPad_mini_GSM,
    DEVICE_SIZE_iPad_mini_CDMA,
    DEVICE_SIZE_iPad_3_Wifi,
    DEVICE_SIZE_iPad_3_GSM,
    DEVICE_SIZE_iPad_3_CDMA,
    DEVICE_SIZE_iPad_4_Wifi,
    DEVICE_SIZE_iPad_4_GSM,
    DEVICE_SIZE_iPad_4_CDMA,
    DEVICE_SIZE_iPad_Air_Wifi,
    DEVICE_SIZE_iPad_Air_4G,
    DEVICE_SIZE_iPad_mini_2_Wifi,
    DEVICE_SIZE_iPad_mini_2_4G,
    DEVICE_SIZE_iPad_mini_2_4G_Mobile,
    DEVICE_SIZE_iPad_mini_3_Wifi,
    DEVICE_SIZE_iPad_mini_3_4G,
    DEVICE_SIZE_iPad_mini_3_4G_Mobile,
    DEVICE_SIZE_iPad_Air_2_Wifi,
    DEVICE_SIZE_iPad_Air_2_4G,
    
    DEVICE_SIZE_SIMULATOR,
    DEVICE_SIZE_UNKNOWN
}EnDEVICETYPE_SIZE;
EnDEVICETYPE_SIZE getDeviceTypeSize();

/*
 *  @brief: 设备类型描述
 */
NSString * stringForDevice();
/*
 *  @brief: 获取内存剩余容量，单位MB
 */
long long getFreeSpaceInKB();

/*
 *  @brief:返回非Null字符串, 如果str是NSNull则返回@“”
 */
NSString *getSafeString(NSString *str);

NSString *stringForBool(BOOL bValue);

/*
 *  @brief:将字符串版本号转换为整数版本号
 *
 *  @param:
 *      strVersion：字符串版本号；如:1.2.3.4
 *
 *  @return:整数版本号; 如:1020304=1*100*100*100+2*100*100+3*100+4
 *
 *  @description:只支持7位，如1.2.3.4.5将只会得到1020304而不是102030405;
 *              如果不足四位(1.2.3)，讲得到值10203000；每一位上最大99；
 */
UInt32 strVersionToIntVersion(NSString *strVersion);

#pragma mark - Authorization
/*
 *  @bief:添加推送通知,使得系统弹出“发送推送通知”确认框
 */
FOUNDATION_EXPORT void alertNotificationAuthorization();

/*
 *  @brief:打开APP Store并显示APP
 */
void openAppStore(NSString *strAppID);
