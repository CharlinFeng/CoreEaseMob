//
//  CoreEaseMob+Common.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob.h"
#import "NSString+Password.h"
#import "EaseMob.h"


typedef enum{
    
    /** 内存 */
    FetchTypeMemory,
    
    /** 本地数据库 */
    FetchTypeDB
    
}FetchType;





@interface CoreEaseMob (Common)

#define ChatManager [EaseMob sharedInstance].chatManager
#define TrigerBlock(block) if (block != nil)block();









/** 添加ChatManager代理 */
+(void)addChatManagerDelegate:(id<EMChatManagerDelegate>)delegate;
/** 移除ChatManager代理 */
+(void)removeChatManagerDelegate:(id<EMChatManagerDelegate>)delegate;


/** 错误处理 */
+(BOOL)handleError:(EMError *)error successMsg:(NSString *)successMsg;



+(void)showSVP:(NSString *)msg;






@end
