//
//  AppDelegate+ChatManagerDelegate.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "AppDelegate+ChatManagerDelegate.h"
#import "CoreEaseMob.h"
#import "BuddyRequestModel.h"

@implementation AppDelegate (ChatManagerDelegate)


/** 将要自动登陆：此方法暂时没有调用,原因未知 */
-(void)willAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error{}

/** 自动登陆完成 */
-(void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error{NSLog(@"%@===",loginInfo);}

/** 将要自动重连 */
-(void)willAutoReconnect{}

/** 自动重连完成 */
-(void)didAutoReconnectFinishedWithError:(NSError *)error{}

/** 监听加好友请求 */
-(void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message{
    
    BuddyRequestModel *m = [BuddyRequestModel modelWithUsername:username message:message];
    
    [CoreEaseMobInstance addBuddyRequest:m];
}

/** 请求添加对方为好友，被对方同意了请求 */
-(void)didAcceptedByBuddy:(NSString *)username{}
/** 请求添加对方为好友，被对方拒绝了请求 */
-(void)didRejectedByBuddy:(NSString *)username{}






@end
