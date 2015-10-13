//
//  NSString+AppURL.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "NSString+AppURL.h"

@implementation NSString (AppURL)


-(NSString *)completeURL{return [NSString stringWithFormat:@"%@%@",URL_HOST,self];}

@end
