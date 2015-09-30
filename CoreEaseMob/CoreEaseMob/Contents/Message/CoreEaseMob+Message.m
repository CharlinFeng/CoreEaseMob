//
//  CoreEaseMob+Chat.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/6.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob+Message.h"

@implementation CoreEaseMob (Message)

/** 文字消息构造 */
+(id<IEMMessageBody>)messageText:(NSString *)sayText{
    EMChatText *txtChat = [[EMChatText alloc] initWithText:sayText];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:txtChat];
    return body;
}


/** 图片消息构造 */
+(id<IEMMessageBody>)messageImg:(UIImage *)img displayName:(NSString *)displayName{
    EMChatImage *imgChat = [[EMChatImage alloc] initWithUIImage:img displayName:displayName];
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithChatObject:imgChat];
    return body;
}


/** 位置消息构造 */
+(id<IEMMessageBody>)messageLocationWithLatitude:(double)latitude longitude:(double)longitude address:(NSString *)address{
    EMChatLocation *locChat = [[EMChatLocation alloc] initWithLatitude:latitude longitude:longitude address:address];
    EMLocationMessageBody *body = [[EMLocationMessageBody alloc] initWithChatObject:locChat];
    return body;
}


/** 语音消息构造 */
+(id<IEMMessageBody>)messageVoiceWithRecordPath:(NSString *)recordPath aDuration:(NSInteger)aDuration displayName:(NSString *)displayName{
    
    EMChatVoice *voice = [[EMChatVoice alloc] initWithFile:recordPath displayName:displayName];
    voice.duration = aDuration;
    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithChatObject:voice];
    return body;
}



/** 文件消息构造 */
+(id<IEMMessageBody>)messageFileWithLocalPath:(NSString *)localPath displayName:(NSString *)displayName{
    
    EMChatFile *fileChat = [[EMChatFile alloc] initWithFile:localPath displayName:displayName];
    EMFileMessageBody *body = [[EMFileMessageBody alloc] initWithChatObject:fileChat];
    return body;
}


/** 透传消息构造 */
+(id<IEMMessageBody>)messageCommand:(NSString *)cmd{
    
    EMChatCommand *cmdChat = [[EMChatCommand alloc] init];
    cmdChat.cmd = cmd;
    EMCommandMessageBody *body = [[EMCommandMessageBody alloc] initWithChatObject:cmdChat];
    return body;
}


/** 生成message */
+(EMMessage *)buildForUsername:(NSString *)username messageBody:(id<IEMMessageBody>)messageBody {
    
    EMMessage *message = [[EMMessage alloc] initWithReceiver:username bodies:@[messageBody]];
    message.messageType = eMessageTypeChat; // 设置为单聊消息
    return message;
}





@end
