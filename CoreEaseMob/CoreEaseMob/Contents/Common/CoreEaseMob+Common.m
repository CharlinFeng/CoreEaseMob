//
//  CoreEaseMob+Common.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob+Common.h"
#import "CoreSVP.h"

@implementation CoreEaseMob (Common)



/** 添加一个ChatManager代理 */
+(void)addChatManagerDelegate:(id<EMChatManagerDelegate>)delegate{
    [ChatManager addDelegate:delegate delegateQueue:nil];
}

/** 移除ChatManager代理 */
+(void)removeChatManagerDelegate:(id<EMChatManagerDelegate>)delegate{
    [ChatManager removeDelegate:delegate];
}







/** 错误处理 */
+(BOOL)handleError:(EMError *)error successMsg:(NSString *)successMsg;{
    
    BOOL res = error != nil;
    
    if (res) {
        
        NSString *errorMsg = [NSString stringWithFormat:@"%@：%@",@(error.errorCode),error.description];
        
        [CoreSVP showSVPWithType:CoreSVPTypeError Msg:errorMsg duration:2.0 allowEdit:NO beginBlock:nil completeBlock:nil];
        
    }else{
        
        if(successMsg != nil){
            [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:successMsg duration:1.0 allowEdit:NO beginBlock:nil completeBlock:nil];
        }
    }
    
    return res;
}




+(void)showSVP:(NSString *)msg{
    [CoreSVP showSVPWithType:CoreSVPTypeLoadingInterface Msg:msg duration:0 allowEdit:NO beginBlock:nil completeBlock:nil];
}


@end
