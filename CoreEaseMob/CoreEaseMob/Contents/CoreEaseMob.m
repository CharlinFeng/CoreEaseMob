//
//  CoreEaseMob.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEaseMob.h"


@interface CoreEaseMob ()

@property (nonatomic,strong) NSMutableArray *buddyRequestsM;

@end




@implementation CoreEaseMob
SingletonM(CoreEaseMob)


/** 追加好友请求 */
-(void)addBuddyRequest:(BuddyRequestModel *)buddyRequesttModel{if(![self.buddyRequestsM containsObject:buddyRequesttModel]) [self.buddyRequestsM addObject:buddyRequesttModel];}

/** 移除好友申请 */
-(void)removeBuddyRequest:(BuddyRequestModel *)buddyRequesttModel{
    [self.buddyRequestsM enumerateObjectsUsingBlock:^(BuddyRequestModel * brm, NSUInteger idx, BOOL *stop) {
        if(brm.username == buddyRequesttModel.username) {[self.buddyRequestsM removeObject:brm];}
    }];
}








-(NSMutableArray *)buddyRequestsM{
    
    if(_buddyRequestsM ==nil){
        
        _buddyRequestsM = [NSMutableArray array];
    }
    
    return _buddyRequestsM;
}


-(NSArray *)buddyRequests{return self.buddyRequestsM;}

@end
