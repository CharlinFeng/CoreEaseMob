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

@interface AppDelegate ()<IChatManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [CoreEaseMob registerEaseMobSDK:application launchOptions:launchOptions];

    [CoreEaseMob addChatManagerDelegate:self];
    
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

@end
