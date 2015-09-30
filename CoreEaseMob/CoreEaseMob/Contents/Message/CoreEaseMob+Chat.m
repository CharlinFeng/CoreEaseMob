//
//  CoreEaseMob+Chat.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/6.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob+Chat.h"
#import "CoreEaseMob+Common.h"

@implementation CoreEaseMob (Chat)


/** 发送一条消息 */
+(EMMessage *)sendMessage:(EMMessage *)message progress:(id<IEMChatProgressDelegate>)progress prepareBlock:(void(^)())prepareBlock completeBlock:(void(^)())completeBlock errorBlock:(void(^)(EMError *error))errorBlock{
    
    EMMessage *sendMsg = [ChatManager asyncSendMessage:message progress:progress prepare:^(EMMessage *message, EMError *error) {
        
        if(error != nil){if(errorBlock != nil) errorBlock(error);}
        else{TrigerBlock(prepareBlock)}
        
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        
        if(error != nil){if(errorBlock != nil) errorBlock(error);}
        else{ TrigerBlock(completeBlock)}
        
    } onQueue:nil];
    
    return sendMsg;
}


@end
