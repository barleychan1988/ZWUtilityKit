//
//  AppUpdate.h
//  dataHandler
//
//  Created by 陈正旺 on 14-9-26.
//  Copyright (c) 2014年 chenzhengwang. All rights reserved.
//

/*
 *
 *  @brief:App应用版本更新
 *
 *  @create time: 2014-09-26
 *  @update time: 2014-11-13
 *
 *  @description:支持版本号以“1.1.1.1”形式标记
 */

#import <Foundation/Foundation.h>

@protocol updateDelegate <NSObject>

/*
 *  @brief:检测版本完成时,调用代理方法
 *  @param:
 *      strLastestVersion：最新版本号
 *      bHasNewVersion：是否有新版本标志
 *      strAppUrl：App下载地址(企业版本升级时需要)
 */
-(void)updateAppToVersion:(NSString *)strLastestVersion hasNewVersion:(BOOL)bHasNewVersion appUrl:(NSString *)strAppUrl;

@end


@interface AppUpdate : NSObject

/*
 *  @brief:检查应用程序在App Store上是否有新版本
 *  @param:
 *      strAppID：应用程序在App Store上的ID
 *      delegate：成功或失败所执行的方法所属的对象
 */
-(void)checkUpdateAtStore:(NSString *)strAppID delegate:(id<updateDelegate>)delegate;

/*
 *  @brief:app为企业版时，检查应用程序在本公司网站上是否有新版本
 *  @param:
 *      strUrl：应用程序在App Store上的ID
 *      param：升级版本接口地址
 *      delegate：成功或失败所执行的方法所属的对象
 */
-(void)checkUpdateAtWebsite:(NSString *)strUrl param:(NSDictionary *)dicParam delegate:(id<updateDelegate>)delegate;

@end

void checkUpdateAtStore(NSString *strAppID, id<updateDelegate> delegate);
void checkUpdateAtWebsite(NSString *strUrl, NSDictionary *dicParam, id<updateDelegate> delegate);

/* 
 *  @brief:一般在代理中现实
 *
#pragma mark - AppUpdate Delegate

-(void)updateAppToVersion:(NSString *)strLastestVersion hasNewVersion:(BOOL)bHasNewVersion appUrl:(NSString *)strAppUrl
{
    if (bHasNewVersion)
    {
        if ([strAppUrl isKindOfClass:[NSString class]] && [strAppUrl length] > 0)
        {
            m_strAppUrl = strAppUrl;
        }
        else
        {
            m_strAppUrl = nil;
        }
        NSString *str = [NSString stringWithFormat:@"新的版本号为:%@", strLastestVersion];
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"有新版本更新" message:str delegate:self cancelButtonTitle:@"幸福的去更新" otherButtonTitles:@"残忍的拒绝", nil];
        [RootObject getRootObject].ifNewVersion = YES;
        alert.tag = 44;
        [alert show];
    }
    else if (_bShowUpdateTip)
    {
        [SVProgressHUD showSuccessWithStatus:@"当前已经是最新版本"];
    }else
    {
        [RootObject getRootObject].ifNewVersion = NO;
    }
    _bShowUpdateTip = NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 44)
    {
        if (buttonIndex == 0)
        {
            NSString *str;
            if ([m_strAppUrl length] > 0)
            {
                str = m_strAppUrl;
            }
            else
            {
                str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@", APP_ID];
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }
}
*/

#pragma mark - hot update

void checkHotupdate();
