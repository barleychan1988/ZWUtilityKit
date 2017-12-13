//
//  ZWVertifyStringKit.m
//  ZWUtilityKit
//
//  Created by EadkennyChan on 16/7/28.
//  Copyright © 2016年 zwchen. All rights reserved.
//

#import "ZWVertifyStringKit.h"

BOOL execRegEx(NSString *strRegEx, NSString *str)
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strRegEx];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

BOOL isIdentifierValidate(NSString *strIdentifier)
{
    BOOL bRet = NO;
    if ([strIdentifier isKindOfClass:[NSString class]] && [strIdentifier length] == 18)
    {
        //二代身份证校验
        unichar cNum;
        int n;
        long lSum = 0;
        NSArray *arrayCoefficient = @[@7,@9,@10,@5,@8,@4,@2,@1,@6,@3,@7,@9,@10,@5,@8,@4,@2];//2^(i-1)%11  (i=2,3....18)从右至左，最左侧为18，最右侧位1
        for (n = 0; n < [strIdentifier length] - 1; n++)
        {
            cNum = [strIdentifier characterAtIndex:n];
            if (cNum >= '0' && cNum <= '9')
            {
                lSum += ((cNum - '0') * ((NSNumber *)[arrayCoefficient objectAtIndex:n]).intValue);
            }
            else
            {
                break;
            }
        }
        cNum = [strIdentifier characterAtIndex:n++];
        if (cNum == 'x' || cNum == 'X')
        {
            cNum = 10;
        }
        else if (cNum >= '0' && cNum <= '9')
        {
            cNum -= '0';
        }
        else
        {
            n = 0;
        }
        if (n == ([strIdentifier length]))
        {
            lSum %= 11;
            switch (lSum)
            {
                case 0:
                    lSum = 1;
                    break;
                case 1:
                    lSum = 0;
                    break;
                case 2:
                    lSum = 10;
                    break;
                case 3:
                    lSum = 9;
                    break;
                case 4:
                    lSum = 8;
                    break;
                case 5:
                    lSum = 7;
                    break;
                case 6:
                    lSum = 6;
                    break;
                case 7:
                    lSum = 5;
                    break;
                case 8:
                    lSum = 4;
                    break;
                case 9:
                    lSum = 3;
                    break;
                case 10:
                    lSum = 2;
                    break;
                default:
                    break;
            }
            if (lSum == cNum)
            {
                bRet = YES;
            }
        }
    }
    //    if (!bRet)
    //    {
    //        NSLog(@"非有效二代身份证");
    //        m_label.text = @"非有效二代身份证";
    //    }
    //    else
    //    {
    //        m_label.text = @"有效二代身份证";
    //        NSLog(@"有效二代身份证");
    //    }
    return bRet;
}

IDENTIFIER_Sexuality getSexuality(NSString *strIdentifier)
{
    if (isIdentifierValidate(strIdentifier))
    {
        unichar cNum = [strIdentifier characterAtIndex:16];
        if ((cNum - '0') % 2)
        {
            return Sexuality_Female;
        }
    }
    else
    {
        return Sexuality_unknown;
    }
    return Sexuality_Male;
}

/**
 *  检测是否是合法手机号码
 *
 *  @param str 手机号码字符串
 *
 *  @return yes-正确手机号码 no-错误手机号码
 */
BOOL isLegalTelephoneNumber(NSString *str)
{
    if (!isPureDigital(str))
    {
        return NO;
    }
    str = [str stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [str length])];
    
    if ([str length] == 0)
    {
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(14[4-8])|(15[^4,\\D])|(166)|(17[0-9])|(18[0-9])|(19[8-9]))\\d{8}$";
    return execRegEx(regex, str);
}

BOOL isLegalEmail(NSString *str)
{
    NSString *regex = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    return execRegEx(regex, str);
}

BOOL isPureChinese(NSString *str)
{
    NSString *regex = @"^[\\u4e00-\\u9fa5]{0,}$";
    return execRegEx(regex, str);
}

BOOL isPureDigital(NSString *str)
{
    NSString *regex = @"[0-9]*";
    return execRegEx(regex, str);
}

NSString *getSerialNumberFromString(NSString *strSource, NSInteger nMinLenth, NSInteger nMaxLenth)
{
    NSString *strRet = nil;
    NSError *error;
    // 创建NSRegularExpression对象并指定正则表达式
    NSString *strPattern = [NSString stringWithFormat:@"[0-9]{%ld,%ld}", (long)nMinLenth, (long)nMaxLenth];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:strPattern options:0 error:&error];
    if (!error) // 如果没有错误
    {
        // 获取特特定字符串的范围
        NSTextCheckingResult *match = [regex firstMatchInString:strSource options:0 range:NSMakeRange(0, [strSource length])];
        if (match) // 截获特定的字符串
        {
            strRet = [strSource substringWithRange:match.range];
        }
    }
    return strRet;
}

BOOL isRegularAccount(NSString *str)
{
    NSString *strRegEx = @"^\\w+$";
    return execRegEx(strRegEx, str);
}

BOOL isValidBankCardNo(NSString *cardNo)
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--)
    {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 )
        {
            if((i % 2) == 0)
            {
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }
            else
            {
                oddsum += tmpVal;
            }
        }
        else
        {
            if((i % 2) == 1)
            {
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }
            else
            {
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}
