//
//  CoreEaseMob+Login.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob+RegisterAndLogin.h"
#import "CoreEaseMob+Common.h"
#import "CoreSVP.h"

@implementation CoreEaseMob (RegisterAndLogin)


/** 用户注册 */
+(void)registerNewAccount:(NSString *)newAccount password:(NSString *)password completionBlock:(void(^)(NSString *username, NSString *password))completionBlock errorBlock:(void(^)(NSString *newAccount))errorBlock{
    
    [ChatManager asyncRegisterNewAccount:newAccount password:password withCompletion:^(NSString *username, NSString *password, EMError *error) {
        
        if(![CoreEaseMob handleError:error successMsg:nil]){
            if(completionBlock != nil) completionBlock(username,password);
        }else{
            if(errorBlock != nil){errorBlock(newAccount);}
        }
        
        
        
    } onQueue:nil];
}



/** 是否启用自动登陆 */
+(BOOL)isAutoLoginEnabled{
    return [ChatManager isAutoLoginEnabled];
}


/** 登陆 */
+(void)loginInWithUsername:(NSString *)username password:(NSString *)password completionBlock:(void(^)(NSDictionary *loginInfo))completionBlock errorBlock:(void(^)())errorBlock{
    
    if(![self isAutoLoginEnabled]){
        
        [CoreEaseMob showSVP:@"登陆中"];
        
        [ChatManager asyncLoginWithUsername:username password:password completion:^(NSDictionary *loginInfo, EMError *error) {
            
            if(![CoreEaseMob handleError:error successMsg:@"登陆成功"]){
                
                //设置自动登陆
                [ChatManager setIsAutoLoginEnabled:YES];
            
                if(completionBlock != nil) {completionBlock(loginInfo);}
            }else{TrigerBlock(errorBlock)}
            
        } onQueue:nil];
    }
}



/** 退出登陆 */
+(void)loginOffWithUnbindDeviceToken:(BOOL)unbindDeviceToken completionBlock:(void(^)(NSDictionary *info))completionBlock{
    
    [CoreEaseMob showSVP:@"退出中"];
    
    [ChatManager asyncLogoffWithUnbindDeviceToken:unbindDeviceToken completion:^(NSDictionary *info, EMError *error) {
        
        if(![CoreEaseMob handleError:error successMsg:@"退出成功"]){if(completionBlock != nil) {completionBlock(info);}}
        
    } onQueue:nil];
}



@end
