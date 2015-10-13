//
//  HostUserModel.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "HostUserModel.h"

@implementation HostUserModel

CoreArchiver_MODEL_M

+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"hostID":@"id"};
}

@end
