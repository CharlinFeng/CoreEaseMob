//
//  ChatCell.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/8.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreEaseMob.h"


@interface ChatCell : UITableViewCell

@property (nonatomic,strong) id<IEMMessageBody> body;

@property (nonatomic,assign) BOOL isFriend;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
