//
//  Usermodel.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreArchiveHeader.h"
#import "CoreArchive.h"

@interface HXUsermodel : NSObject

CoreArchiver_MODEL_H

@property (nonatomic,copy) NSString *LastLoginTime,*jid,*password,*token,*resource,*username;


@end
