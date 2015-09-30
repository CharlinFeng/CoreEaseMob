//
//  CoreEaseMob+Register.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob+Life.h"


@implementation CoreEaseMob (Life)


/** 注册 */
+(void)registerEaseMobSDK:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions{
    [[EaseMob sharedInstance] registerSDKWithAppKey:CoreHXAppkey apnsCertName:@"push"];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}



/** App 进入后台 */
+(void)appEnterBackground:(UIApplication *)application{
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}



/** App即将从后台转为前台 */
+(void)appWillEnterForeground:(UIApplication *)application{
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}



/** 程序即将被挂起：申请处理时间 */
+(void)appWillTerminate:(UIApplication *)application{
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}



@end
