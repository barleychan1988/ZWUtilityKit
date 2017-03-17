//
//  ZWVertifyStringKit.h
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/7/28.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *  @brief:校验常用的字符串
 */

/*
 * @brief:检测字符串是否符合相应正则表达式
 * @param:
 *      strRegEx:正则表达式
 *      str:检测的字符串
 */
BOOL execRegEx(NSString *strRegEx, NSString *str);


typedef enum sexuality
{
    Sexuality_unknown = 0,  //证件号错误
    Sexuality_Male,
    Sexuality_Female
}IDENTIFIER_Sexuality;
/*
 *  @brief:获取性别
 *  @param:
 *      strIdentifier:二代身份证号码
 */
IDENTIFIER_Sexuality getSexuality(NSString *strIdentifier);
/*
 *  @brief:检查二代身份证(18位)是否为有效身份证
 *  @param:
 *      strIdentifier:二代身份证号码
 */
BOOL isIdentifierValidate(NSString *strIdentifier);
/*
 *  检测是否是合法手机号码
 *
 *  @param
 *      str 手机号码字符串
 *
 *  @return
 *      yes-正确手机号码
 *      no-错误手机号码
 */
BOOL isLegalTelephoneNumber(NSString *str);
/*
 *  检测是否是合法邮箱账号
 *
 *  @param
 *      str 手机号码字符串
 *
 *  @return
 *      yes-正确手机号码
 *      no-错误手机号码
 */
BOOL isLegalEmail(NSString *str);
/*
 *  检测是否是纯中文字符串
 */
BOOL isPureChinese(NSString *str);

/*
 *  @brief:验证是否为纯数字字符串
 */
BOOL isPureDigital(NSString *strNumber);

/*
 *  @brief:从字符串中提取连续的数字串
 *  @param:
 *      nMinLenth：需要提取的数字串的最小长度
 *      nMaxLenth：需要提取的数字串的最大长度
 */
NSString *getSerialNumberFromString(NSString *strSource, NSInteger nMinLenth, NSInteger nMaxLenth);
/*
 *  由数字、26个英文字母或下划线组成的字符串
 */
BOOL isRegularAccount(NSString *str);
