//
//  CoreEaseMob+Buddy.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob.h"


@interface CoreEaseMob (Buddy)



/** 获取好友列表 */
+(void)fetchBuddyList:(void(^)(NSArray *buddyList))buddyListWithCompletion;



/** 设置自动获取好友列表 */
+(void)setIsAutoFetchBuddyList;



/**
 *  发送添加好友申请
 *  如果您已经发过，并且对方没有处理，您将不能再次发送
 */
+(BOOL)addBuddyWithUsername:(NSString *)username message:(NSString *)message;



/** 处理加好友申请：同意/拒绝 */
+(BOOL)handleBuddyRequest:(NSString *)username isAccept:(BOOL)isAccept rejectReason:(NSString *)rejectReason;



/** 删除好友 */
+(BOOL)removeBuddyWithUsername:(NSString *)username removeFromRemote:(BOOL)removeFromRemote;



/** 加入黑名单 */
+(BOOL)blockBuddyWithUsername:(NSString *)username relationship:(EMRelationship)relationship;



/** 移出黑名单 */
+(BOOL)unblockBuddyWithUsername:(NSString *)username;


/** 获取好友黑名单 */
+(void)fetchBlockedListWithCompletionBlock:(void(^)(NSArray *blockedList))completionBlock errorBlock:(void(^)())errorBlock;




@end
