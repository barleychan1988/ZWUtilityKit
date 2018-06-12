//
//  AppUpdate.m
//  dataHandler
//
//  Created by 陈正旺 on 14-9-26.
//  Copyright (c) 2014年 chenzhengwang. All rights reserved.
//

#import "AppUpdate.h"
#import "Dictionary+SafeValue.h"
#import "ZWMacroDef.h"
//#import "ZWLog.h"
#import <UIKit/UIApplication.h>

@interface AppUpdate()
{
    __weak id<updateDelegate> m_delegate;
    
    BOOL m_bStore;
    NSString *m_strAppID;
}
@property (nonatomic, retain)NSURLSessionDataTask *taskCurrent;
@end

@implementation AppUpdate

-(void)checkUpdateAtStore:(NSString *)strAppID delegate:(id<updateDelegate>)delegate NS_AVAILABLE_IOS(7_0);
{
    m_bStore = YES;
    m_strAppID = strAppID;
    m_delegate = delegate;
    
    NSDictionary *dicParam = [NSDictionary dictionaryWithObjectsAndKeys:strAppID, @"id", nil];
    
    NSMutableString *mtStrUrl = [[NSMutableString alloc] initWithString:@"http://itunes.apple.com/cn/lookup"];
    NSArray *arrayKey = [dicParam allKeys];
    for (int i=0; i<[arrayKey count]; i++)
    {
        if (i == 0)
        {
            [mtStrUrl appendString:@"?"];
        }
        else
        {
            [mtStrUrl appendString:@"&"];
        }
        [mtStrUrl appendString:[arrayKey objectAtIndex:i]];
        [mtStrUrl appendString:@"="];
        [mtStrUrl appendString:[dicParam objectForKey:[arrayKey objectAtIndex:i]]];
    }
    NSString *strTempUrl = [[NSString alloc] initWithString:mtStrUrl];
    
    strTempUrl = [strTempUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *nsUrl = [NSURL URLWithString:strTempUrl];
    
    __weak AppUpdate *weakObject = self;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:nsUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {[weakObject handleResult:nil error:error responseObject:data];}];
    [dataTask resume];
    _taskCurrent = dataTask;
}

-(void)checkUpdateAtWebsite:(NSString *)strUrl param:(NSDictionary *)dicParam delegate:(id<updateDelegate>)delegate NS_AVAILABLE_IOS(7_0);
{
    m_delegate = delegate;
    
    NSMutableString *mtStrUrl = [[NSMutableString alloc] initWithString:strUrl];
    NSArray *arrayKey = [dicParam allKeys];
    for (int i=0; i<[arrayKey count]; i++)
    {
        if (i==0)
        {
            [mtStrUrl appendString:@"?"];
        }
        else
        {
            [mtStrUrl appendString:@"&"];
        }
        [mtStrUrl appendString:[arrayKey objectAtIndex:i]];
        [mtStrUrl appendString:@"="];
        [mtStrUrl appendString:[dicParam objectForKey:[arrayKey objectAtIndex:i]]];
    }
    NSString *strTempUrl=[[NSString alloc]initWithString:mtStrUrl];
    
    strTempUrl = [strTempUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *nsUrl = [NSURL URLWithString:strTempUrl];
    
    __weak AppUpdate *weakObject = self;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:nsUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {[weakObject handleResult:nil error:error responseObject:data];}];
    [dataTask resume];
    _taskCurrent = dataTask;
}

- (void)handleResult:(BlockBoolStrObject)completionHandler error:(NSError *)error responseObject:(NSData *)responseObject
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    _taskCurrent = nil;
    NSString *strCurVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    BlockVoid handler = ^{
        if (error)
        {
            if ([self->m_delegate respondsToSelector:@selector(updateAppToVersion:hasNewVersion:appUrl:)])
            {
                [self->m_delegate updateAppToVersion:strCurVersion hasNewVersion:NO appUrl:nil];
            }
            self->m_delegate = nil;
            self->m_bStore = NO;
        }
        else
        {
            if (responseObject == nil || responseObject.length == 0)
            {
            }
            else
            {
                NSDictionary *dicRet = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if ([dicRet count] > 0)
                {
                    //版本号一般为“1.2.6”   转换为 10000-990000 100-9900 0-99
                    UInt32 unNewVersion = 0;
                    UInt32 unCurVersion = [self strVersionToIntVersion:strCurVersion];
                    NSString *strNewVersion = @"";
                    NSString *strAppUrl = nil;
                    NSString *strMsg;
                    if (self->m_bStore)
                    {
                        NSArray *arrayResult = [dicRet safeObjectForKey:@"results"];
                        if ([arrayResult isKindOfClass:[NSArray class]] && [arrayResult count] >= 1)
                        {
                            NSDictionary *dicResult = [arrayResult objectAtIndex:0];
                            strNewVersion = [dicResult stringValueForKey:@"version"];
                            strAppUrl = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@", self->m_strAppID];
                        }
                    }
                    else
                    {
                        strNewVersion = [self parseWebsiteData:dicRet appUrl:&strAppUrl];
                        
                        NSArray *arrayResult = [dicRet safeObjectForKey:@"PageData"];
                        if ([arrayResult isKindOfClass:[NSArray class]] && [arrayResult count] > 0)
                        {
                            NSDictionary *dicResult = [arrayResult objectAtIndex:0];
                            strMsg = [dicResult stringValueForKey:@"Remark"];
                        }
                    }
                    unNewVersion = [self strVersionToIntVersion:strNewVersion];
                    if (unNewVersion > unCurVersion)
                    {
                        if (strMsg.length > 0)
                            [self->m_delegate updateAppToVersion:strNewVersion hasNewVersion:YES appUrl:strAppUrl message:strMsg];
                        else
                            [self->m_delegate updateAppToVersion:strNewVersion hasNewVersion:YES appUrl:strAppUrl];
                        self->m_delegate = nil;
                        self->m_bStore = NO;
                        return;
                    }
                }
            }
            if ([self->m_delegate respondsToSelector:@selector(updateAppToVersion:hasNewVersion:appUrl:)])
            {
                [self->m_delegate updateAppToVersion:strCurVersion hasNewVersion:NO appUrl:nil];
            }
            self->m_delegate = nil;
            self->m_bStore = NO;
        }
    };
    dispatch_async(dispatch_get_main_queue(), handler);
}

#pragma mark - 解析返回数据
/*
 *  @brief:解析返回的版本数据
 *  @param:
 *      dicData：
 *  @return:解析出来的版本号
 */
- (NSString *)parseWebsiteData:(NSDictionary *)dicData appUrl:(NSString **)pstrAppUrl
{
    NSString *strRet = @"";
    NSMutableArray *dataArray = [dicData objectForKey:@"PageData"];
    if ([dataArray isKindOfClass:[NSArray class]] && [dataArray count] > 0)
    {
        NSDictionary *dicVersionData = [dataArray objectAtIndex:0];
        if ([dicVersionData isKindOfClass:[NSDictionary class]] && [dicVersionData count] > 0)
        {
            strRet = [dicVersionData stringValueForKey:@"PhoneVersion"];
            if (![strRet isKindOfClass:[NSString class]])
            {
                strRet = @"";
            }
            else
            {
                *pstrAppUrl = [dicVersionData stringValueForKey:@"IosFileUrl"];
            }
        }
    }
    return strRet;
}
/*
 *  @brief:将字符串版本号转换为整数版本号
 *
 *  @param:
 *      strVersion：字符串版本号；如:1.2.3.4
 *
 *  @return:整数版本号; 如:1020304=1*100*100*100+2*100*100+3*100+4
 *
 *  @description:只支持四位，如1.2.3.4.5将只会得到1020304而不是102030405;
 *              如果不足四位(1.2.3)，讲得到值10203000；每一位上最大99；
 */
- (UInt32)strVersionToIntVersion:(NSString *)strVersion
{
    NSArray *arrayComponentVersion = [strVersion componentsSeparatedByString:@"."];
    NSString *strVerNum;
    UInt32 unVersion = 0;
    for (int i = 0; i < 4; i++)
    {
        unVersion *= 100;
        
        if (i < [arrayComponentVersion count])
        {
            strVerNum = [arrayComponentVersion objectAtIndex:i];
            unVersion += [strVerNum intValue];
        }
    }
    return unVersion;
}

@end

void checkUpdateAtStore(NSString *strAppID, id<updateDelegate> delegate)
{
    AppUpdate *appUpdate = [[AppUpdate alloc] init];
    [appUpdate checkUpdateAtStore:strAppID delegate:delegate];
}

void checkUpdateAtWebsite(NSString *strUrl, NSDictionary *dicParam, id<updateDelegate> delegate)
{
    AppUpdate *appUpdate = [[AppUpdate alloc] init];
    [appUpdate checkUpdateAtWebsite:strUrl param:dicParam delegate:delegate];
}

#pragma mark - hot update

void checkHotupdate()
{
    
}
