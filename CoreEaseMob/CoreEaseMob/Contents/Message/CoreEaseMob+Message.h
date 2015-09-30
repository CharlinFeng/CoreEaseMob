//
//  CoreEaseMob+Chat.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/6.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob.h"
#import "EaseMob.h"


@interface CoreEaseMob (Message)


/** 文字消息构造 */
+(id<IEMMessageBody>)messageText:(NSString *)sayText;


/** 图片消息构造 */
+(id<IEMMessageBody>)messageImg:(UIImage *)img displayName:(NSString *)displayName;


/** 位置消息构造 */
+(id<IEMMessageBody>)messageLocationWithLatitude:(double)latitude longitude:(double)longitude address:(NSString *)address;


/** 语音消息构造 */
+(id<IEMMessageBody>)messageVoiceWithRecordPath:(NSString *)recordPath aDuration:(NSInteger)aDuration displayName:(NSString *)displayName;


/** 文件消息构造 */
+(id<IEMMessageBody>)messageFileWithLocalPath:(NSString *)localPath displayName:(NSString *)displayName;


/** 透传消息构造 */
+(id<IEMMessageBody>)messageCommand:(NSString *)cmd;


/** 生成message */
+(EMMessage *)buildForUsername:(NSString *)username messageBody:(id<IEMMessageBody>)messageBody;


@end
