//
//  CoreEaseMob.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#define CoreHXAppkey @"896249676#testlan"
#define CoreCertName @"CoreEaseMob"
#define CoreEaseMobInstance [CoreEaseMob sharedCoreEaseMob]
#define EaseMobInstance [EaseMob sharedInstance]

#import <Foundation/Foundation.h>
#import "EaseMob.h"
#import "CoreEaseMobSingleton.h"
#import "BuddyRequestModel.h"



@interface CoreEaseMob : NSObject
SingletonH(CoreEaseMob)

@property (nonatomic,strong) NSArray *buddyRequests;

/** 追加好友请求 */
-(void)addBuddyRequest:(BuddyRequestModel *)buddyRequesttModel;
/** 移除好友申请 */
-(void)removeBuddyRequest:(BuddyRequestModel *)buddyRequesttModel;



@end
