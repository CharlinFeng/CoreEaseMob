//
//  BuddyRequestModel.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/4.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuddyRequestModel : NSObject

@property (nonatomic,copy) NSString *username,*message;

+(instancetype)modelWithUsername:(NSString *)username message:(NSString *)message;

@end
