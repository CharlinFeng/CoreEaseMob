//
//  BuddyRequestModel.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/4.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "BuddyRequestModel.h"

@implementation BuddyRequestModel


+(instancetype)modelWithUsername:(NSString *)username message:(NSString *)message{
    
    BuddyRequestModel *m = [[BuddyRequestModel alloc] init];
    
    m.username = username;
    m.message = message;
    
    return m;
}



@end
