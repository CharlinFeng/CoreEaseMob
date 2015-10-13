//
//  SearchView.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "SearchView.h"

@interface SearchView ()

@property (weak, nonatomic) IBOutlet UITextField *tf;


@end




@implementation SearchView


+(instancetype)searchView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:nil options:nil].firstObject;
}


- (IBAction)btnClick:(id)sender {
    
    if(self.SearchAction != nil) self.SearchAction(self.tf.text);
}



@end
