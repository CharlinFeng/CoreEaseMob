//
//  CoreEaseMob+Conversation.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/6.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob+Conversation.h"

@implementation CoreEaseMob (Conversation)


/** 新建/获取一个会话 */
+(EMConversation *)conversationForChatter:(NSString *)username{
    
    EMConversation *conversation = [ChatManager conversationForChatter:username conversationType:eConversationTypeChat];
    return conversation;
}



/** 删除会话: 批量操作 */
+(void)removeConversationByChatters:(NSArray *)chatters{
    
    if(chatters != nil){ //单个及批量删除
        [ChatManager removeConversationsByChatters:chatters deleteMessages:YES append2Chat:YES];
    }else{ //删除所有
        [ChatManager removeAllConversationsWithDeleteMessages:YES append2Chat:YES];
    }
}


/** 获取或创建会话 */
+(NSArray *)loadConversations:(FetchType)fetchType{
    
    NSArray *conversations = nil;
    
    if(fetchType == FetchTypeMemory){
        conversations = [ChatManager conversations];
    }else{
        conversations = [ChatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
    }
    
    return  conversations;
}



/** 获取会话未读消息数 */
+(NSInteger)unreadMessagesCount{
    return [ChatManager loadTotalUnreadMessagesCountFromDatabase];
}



@end
