//
//  SearchView.h
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView


@property (nonatomic,copy) void (^SearchAction)(NSString * str);


+(instancetype)searchView;


@end
