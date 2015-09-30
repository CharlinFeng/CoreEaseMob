//
//  CoreEaseMob+Conversation.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/6.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob.h"
#import "CoreEaseMob+Common.h"

@interface CoreEaseMob (Conversation)


/** 新建/获取一个会话 */
+(EMConversation *)conversationForChatter:(NSString *)username;


/** 删除会话: 批量操作,支持单个、多个、所有（所有请传nil） */
+(void)removeConversationByChatters:(NSArray *)chatters;


/** 获取或创建会话 */
+(NSArray *)loadConversations:(FetchType)fetchType;


/** 获取会话未读消息数 */
+(NSInteger)unreadMessagesCount;


@end
