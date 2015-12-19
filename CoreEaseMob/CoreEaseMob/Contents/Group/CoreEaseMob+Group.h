//
//  CoreEaseMob+Group.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/12/19.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob.h"

@interface CoreEaseMob (Group)


/** 获取群组列表 */
+(void)groupFetchWithSuccessBlock:(void(^)(NSArray<EMGroup *> *groups))successBlock
       errorBlock:(void(^)(EMError *error))errorBlock;



/** 创建群组 */
+(void)groupCreateWithName:(NSString *)groupName
                      desc:(NSString *)desc
              initInvitees:(NSArray<NSString *> *)initInvitees
     initialWelcomeMessage:(NSString *)initialWelcomeMessage
                groupStyle:(EMGroupStyle)groupStyle
            maxMemberCount:(NSInteger)maxMemberCount
              successBlock:(void(^)(EMGroup *group))successBlock
                errorBlock:(void(^)(EMError *error))errorBlock;


/** 解散群组 */
+(void)groupDestroyWithID:(NSString *)groupID successBlock:(void(^)(EMGroup *group, EMGroupLeaveReason reason))successBlock
               errorBlock:(void(^)(EMError *error))errorBlock;




/** 添加群成员 */
+(void)groupAddOccupants:(NSArray <NSString *> *)occupants toGroup:(NSString *)groupID welcomeMessage:(NSString *)welcomeMessage successBlock:(void(^)(EMGroup *group, NSString *welcomeMessage, NSArray *didOccupants))successBlock errorBlock:(void(^)(EMError *error))errorBlock;




@end
