//
//  RegisterVC.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "RegisterVC.h"
#import "NSString+AppURL.h"
#import "CoreSVP.h"
#import "APPHttp.h"
#import "CoreEaseMobHeader.h"

@interface RegisterVC ()

@property (weak, nonatomic) IBOutlet UITextField *umTF;

@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)registerBtnClick:(id)sender {
    
    
    if(self.umTF.text.length == 0 || self.pwdTF.text.length == 0){
        
        [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"请填完" duration:1.0 allowEdit:NO beginBlock:nil completeBlock:nil];
        
        return;
    }
    
    
    NSString *um = self.umTF.text;
    NSString *pwd =self.pwdTF.text.md5;
    
    NSString *url = URL_REGISTER.completeURL;
    
    NSDictionary *params = @{@"username":um,@"pwd": pwd};
    
    /** 先请求服务器，再请求sdk */
    [APPHttp postUrl:url params:params target:nil type:APPHttpTypeNone success:^(id obj) {
        
        [CoreEaseMob registerNewAccount:um password:pwd completionBlock:^(NSString *username, NSString *password) {
            
            [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:@"注册成功" duration:1.0 allowEdit:NO beginBlock:nil completeBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        } errorBlock:^(NSString *newAccount) {
                
            NSString *delURL = URL_DELETE_REGISTER_USER.completeURL;
            
            NSDictionary *params2 = @{@"username": newAccount};
            
            [APPHttp postUrl:delURL params:params2 target:self.view type:APPHttpTypeSVP success:^(id obj) {
                
                [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"注册失败，请重试！" duration:2.0 allowEdit:NO beginBlock:nil completeBlock:nil];
                
            } errorBlock:nil];

        }];

    } errorBlock:nil];
    
    
}




@end
