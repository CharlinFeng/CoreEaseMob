//
//  CoreEaseMob+Buddy.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob+Buddy.h"
#import "CoreEaseMob+Common.h"

@implementation CoreEaseMob (Buddy)



/** 获取好友列表 */
+(void)fetchBuddyList:(void(^)(NSArray *buddyList))buddyListWithCompletion{
    
    [ChatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
        
        if(![CoreEaseMob handleError:error successMsg:nil]){if(buddyListWithCompletion != nil) buddyListWithCompletion(buddyList);}
            
    } onQueue:nil];
}



/** 设置自动获取好友列表 */
+(void)setIsAutoFetchBuddyList{
    
    if(![ChatManager isAutoFetchBuddyList]){[ChatManager setIsAutoFetchBuddyList:YES];}
}


/**
 *  发送添加好友申请
 *  如果您已经发过，并且对方没有处理，您将不能再次发送
 */
+(BOOL)addBuddyWithUsername:(NSString *)username message:(NSString *)message{
    
    EMError *error = nil;
    
    BOOL res = [ChatManager addBuddy:username message:message error:&error];
    
    if(error != nil) res = NO;
    
    return res;
}



/** 处理加好友申请：同意/拒绝 */
+(BOOL)handleBuddyRequest:(NSString *)username isAccept:(BOOL)isAccept rejectReason:(NSString *)rejectReason{
    
    EMError *error = nil;
    BOOL res = NO;
    if(isAccept){
        res=[ChatManager acceptBuddyRequest:username error:&error];
    }else{
        res=[ChatManager rejectBuddyRequest:username reason:rejectReason error:&error];
    }
    
    
    //移除
    [CoreEaseMobInstance removeBuddyRequest:[BuddyRequestModel modelWithUsername:username message:nil]];
    
    if(error != nil) res = NO;
        
    return res;
}


/** 删除好友 */
+(BOOL)removeBuddyWithUsername:(NSString *)username removeFromRemote:(BOOL)removeFromRemote{
    
    EMError *error = nil;
    
    BOOL res = [ChatManager removeBuddy:username removeFromRemote:removeFromRemote error:&error];
    
    if(error != nil) res = NO;
    
    return res;
}



/** 加入黑名单 */
+(BOOL)blockBuddyWithUsername:(NSString *)username relationship:(EMRelationship)relationship{
    
    EMError *error = [ChatManager blockBuddy:username relationship:relationship];
    
    return error == nil;
}



/** 移出黑名单 */
+(BOOL)unblockBuddyWithUsername:(NSString *)username{
    
    EMError *error = [[EaseMob sharedInstance].chatManager unblockBuddy:username];
    
    return error == nil;
}


/** 获取好友黑名单 */
+(void)fetchBlockedListWithCompletionBlock:(void(^)(NSArray *blockedList))completionBlock errorBlock:(void(^)())errorBlock{
    
    [ChatManager asyncFetchBlockedListWithCompletion:^(NSArray *list, EMError *error) {
        
        if(![CoreEaseMob handleError:error successMsg:nil]){
            
            if(completionBlock != nil) completionBlock(list);
            
        }else{TrigerBlock(errorBlock)}
        
    } onQueue:nil];
}


















@end
