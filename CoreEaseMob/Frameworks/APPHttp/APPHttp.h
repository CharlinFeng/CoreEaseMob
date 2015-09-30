//
//  APPHttp.h
//  4s
//
//  Created by muxi on 15/3/10.
//  Copyright (c) 2015年 muxi. All rights reserved.
//  项目网络请求工具，每个需要都需要根据实际情况来配置

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CoreHttp.h"
#import "CoreStatusBtn.h"
#import "APPHttpType.h"







@interface APPHttp : NSObject


/**
 *  GET:
 *  params中可指明参数类型
 *  target:
 *   APPHttpTypeStatusView  ：view
 *   APPHttpTypeSVP         ：nil
 *   APPHttpTypeBtn         ：btn
 */
+(void)getUrl:(NSString *)urlString params:(id)params target:(id)target type:(APPHttpType)type success:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;



/**
 *  POST:
 *   APPHttpTypeStatusView  ：view
 *   APPHttpTypeSVP         ：nil
 *   APPHttpTypeBtn         ：btn
 */
+(void)postUrl:(NSString *)urlString params:(id)params target:(id)target type:(APPHttpType)type success:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;




@end
