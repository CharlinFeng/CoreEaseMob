//
//  CoreEaseMob+Chat.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/6.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob.h"

@interface CoreEaseMob (Chat)


/** 发送一条消息 */
+(EMMessage *)sendMessage:(EMMessage *)message progress:(id<IEMChatProgressDelegate>)progress prepareBlock:(void(^)())prepareBlock completeBlock:(void(^)())completeBlock errorBlock:(void(^)(EMError *error))errorBlock;























@end
