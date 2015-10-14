//
//  LoginVC.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "LoginVC.h"
#import "NSString+AppURL.h"
#import "CoreSVP.h"
#import "APPHttp.h"
#import "FriendsListVC.h"
#import "CoreEaseMobHeader.h"
#import "HXUsermodel.h"
#import "NSObject+MJKeyValue.h"
#import "NSString+Password.h"

@interface LoginVC ()<IChatManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *umTF;

@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (nonatomic,assign) BOOL isLogin;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if([UIScreen mainScreen].bounds.size.width == 320) self.umTF.text = @"uuu";
    });
}





- (IBAction)loginBtnClick:(id)sender {
    
    
    if(self.umTF.text.length == 0 || self.pwdTF.text.length == 0){
        
        [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"请填完" duration:1.0 allowEdit:NO beginBlock:nil completeBlock:nil];
        
        return;
    }
    
    NSString *username = self.umTF.text;
    
    NSString *pwd = self.pwdTF.text.md5;
    
    if (![CoreEaseMob isAutoLoginEnabled]) {
        
        [CoreEaseMob loginInWithUsername:username password:pwd completionBlock:^(NSDictionary *loginInfo) {

            [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:@"登陆环信成功" duration:1.0 allowEdit:NO beginBlock:nil completeBlock:nil];

            HXUsermodel *usermodel = [HXUsermodel objectWithKeyValues:loginInfo];

            //保存模型
            [HXUsermodel saveSingleModel:usermodel forKey:nil];

            [self showFriendListVC];

        } errorBlock:nil];
        
    }else{
        
        [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:@"自动" duration:1.0 allowEdit:NO beginBlock:nil completeBlock:nil];
        
        [self showFriendListVC];
    }
    


}


-(void)showFriendListVC{
    

    FriendsListVC *friendVC = [[FriendsListVC alloc] init];
    
    [self.navigationController pushViewController:friendVC animated:YES];
}


@end
