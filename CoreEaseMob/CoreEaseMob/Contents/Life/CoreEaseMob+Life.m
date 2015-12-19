//
//  CoreEaseMob+Register.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob+Life.h"
#import "EaseUI.h"

@implementation CoreEaseMob (Life)


/** 注册 */
+(void)registerEaseMobSDK:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions{
    
    
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:CoreHXAppkey apnsCertName:CoreCertName];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [[EaseSDKHelper shareHelper] easemobApplication:application
                      didFinishLaunchingWithOptions:launchOptions
                                             appkey:CoreHXAppkey
                                       apnsCertName:CoreCertName
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    //注册推送
    [self registerRemoteNotification];
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


/** 注册推送 */
+(void)registerRemoteNotification{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
#endif
}


/** 将得到的deviceToken传给SDK */
+(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [EaseMobInstance application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}


/** 注册deviceToken失败 */
+(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    [EaseMobInstance application:application didFailToRegisterForRemoteNotificationsWithError:error];
}




@end
