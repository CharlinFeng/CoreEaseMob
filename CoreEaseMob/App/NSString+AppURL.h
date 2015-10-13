//
//  NSString+AppURL.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APPHttp.h"

#define URL_HOST @"http://211.149.151.92/mytest/"
#define URL_RESOURCE @"http://211.149.151.92/"


/** 注册 */
#define URL_REGISTER @"User/register"

/** 登陆 */
#define URL_LOGIN @"User/login"

/** 搜索好友 */
#define URL_SEARCH @"User/serach_friend"

/** 添加好友 */
#define URL_APPLY_FRI @"User/send_friend_apply"

/** 删除好友 */
#define URL_DELETE_FRI @"User/delete_friend"

/** 拉黑/移出黑名单 */
#define URL_HANDLE_FRI @"User/deal_balck_list"




/** 删除注册用户 */
#define URL_DELETE_REGISTER_USER @"User/register_false"




@interface NSString (AppURL)


@property (nonatomic,copy,readonly) NSString *completeURL;


@end
