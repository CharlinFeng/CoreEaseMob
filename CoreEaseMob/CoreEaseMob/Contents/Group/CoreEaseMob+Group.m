//
//  CoreEaseMob+Group.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/12/19.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob+Group.h"
#import "CoreEaseMob+Common.h"
#import "CoreSVP.h"

@implementation CoreEaseMob (Group)


/** 获取群组列表 */
+(void)groupFetchWithSuccessBlock:(void(^)(NSArray<EMGroup *> *groups))successBlock
                       errorBlock:(void(^)(EMError *error))errorBlock{
    
    [ChatManager asyncFetchMyGroupsListWithCompletion:^(NSArray *groups, EMError *error) {

        if(error != nil){
            CoreSVPError(error.description)
            if (errorBlock != nil) {errorBlock(error);}; return;
        }
        
        if(successBlock != nil){successBlock(groups);}
        
        
    } onQueue:nil];
}






/** 创建群组 */
+(void)groupCreateWithName:(NSString *)groupName
                      desc:(NSString *)desc
              initInvitees:(NSArray<NSString *> *)initInvitees
     initialWelcomeMessage:(NSString *)initialWelcomeMessage
                groupStyle:(EMGroupStyle)groupStyle
            maxMemberCount:(NSInteger)maxMemberCount
              successBlock:(void(^)(EMGroup *group))successBlock
                errorBlock:(void(^)(EMError *error))errorBlock{
    
    EMError *error = nil;
    EMGroupStyleSetting *groupStyleSetting = [[EMGroupStyleSetting alloc] init];
    groupStyleSetting.groupMaxUsersCount = maxMemberCount; // 如果不设置，默认是200人。
    groupStyleSetting.groupStyle = groupStyle; // 创建不同类型的群组，这里需要才传入不同的类型
    EMGroup *group = [ChatManager createGroupWithSubject:groupName description:desc invitees:initInvitees initialWelcomeMessage:initialWelcomeMessage styleSetting:groupStyleSetting error:&error];
    
    if(error != nil){
        CoreSVPError(error.description)
        if (errorBlock != nil) {errorBlock(error);}; return;
    }
    
    if(successBlock != nil){successBlock(group);}
}





/** 解散群组 */
+(void)groupDestroyWithID:(NSString *)groupID successBlock:(void(^)(EMGroup *group, EMGroupLeaveReason reason))successBlock
               errorBlock:(void(^)(EMError *error))errorBlock{
    
    [ChatManager asyncDestroyGroup:groupID completion:^(EMGroup *group, EMGroupLeaveReason reason, EMError *error) {

        if(error != nil){
            CoreSVPError(error.description)
            if (errorBlock != nil) {errorBlock(error);}; return;
        }
        
        if(successBlock != nil){successBlock(group, reason);}
        
    } onQueue:nil];
}


/** 添加群成员 */
+(void)groupAddOccupants:(NSArray <NSString *> *)occupants toGroup:(NSString *)groupID welcomeMessage:(NSString *)welcomeMessage successBlock:(void(^)(EMGroup *group, NSString *welcomeMessage, NSArray *didOccupants))successBlock errorBlock:(void(^)(EMError *error))errorBlock{

    [ChatManager asyncAddOccupants:occupants toGroup:groupID welcomeMessage:welcomeMessage completion:^(NSArray *didOccupants, EMGroup *group, NSString *welcomeMessage, EMError *error) {

        if(error != nil){
            CoreSVPError(error.description)
            if (errorBlock != nil) {errorBlock(error);}; return;
        }
        
        if(successBlock != nil){successBlock(group, welcomeMessage, didOccupants);}
        
    } onQueue:nil];

}


@end
