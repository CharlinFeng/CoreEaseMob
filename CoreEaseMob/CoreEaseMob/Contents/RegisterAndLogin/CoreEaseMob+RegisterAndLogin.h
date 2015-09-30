//
//  CoreEaseMob+Login.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob.h"
#import "CoreEaseMob+Common.h"

@interface CoreEaseMob (RegisterAndLogin)



/*
 *  用户注册：先请求服务器接口，成功再请求环信接口。如果请求环信失败，则回调服务器删除刚刚注册成功的用户数据。
 */
/** 用户注册 */
+(void)registerNewAccount:(NSString *)newAccount password:(NSString *)password completionBlock:(void(^)(NSString *username, NSString *password))completionBlock errorBlock:(void(^)(NSString *newAccount))errorBlock;



/** 是否启用自动登陆 */
+(BOOL)isAutoLoginEnabled;



/** 登陆 */
+(void)loginInWithUsername:(NSString *)username password:(NSString *)password completionBlock:(void(^)(NSDictionary *loginInfo))completionBlock errorBlock:(void(^)())errorBlock;



/** 退出登陆 */
+(void)loginOffWithUnbindDeviceToken:(BOOL)unbindDeviceToken completionBlock:(void(^)(NSDictionary *info))completionBlock;





@end
