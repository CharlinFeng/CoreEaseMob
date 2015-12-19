//
//  AppDelegate.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreEaseMobHeader.h"
#import "AppDelegate+ChatManagerDelegate.h"
#import "CoreSVP.h"

@interface AppDelegate ()<IChatManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [CoreEaseMob registerEaseMobSDK:application launchOptions:launchOptions];

    [CoreEaseMob addChatManagerDelegate:self];
    
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];

    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [CoreEaseMob appEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [CoreEaseMob appWillEnterForeground:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [CoreEaseMob appWillTerminate:application];
}



// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [CoreEaseMob application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [CoreEaseMob application:application didFailToRegisterForRemoteNotificationsWithError:error];
    NSLog(@"error -- %@",error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSLog(@"==============!!!===========%@",userInfo);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"==============!!!===========%@",userInfo);
}






@end
