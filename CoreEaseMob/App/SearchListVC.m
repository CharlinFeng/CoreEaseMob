//
//  SearchListTVC.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "SearchListVC.h"
#import "NSString+AppURL.h"
#import "HostUserModel.h"
#import "HXUsermodel.h"
#import "CoreSVP.h"
#import "CoreEaseMobHeader.h"


@interface SearchListVC ()



@end

@implementation SearchListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.dataList == nil) return 0;
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *rid = @"SearchListVC";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    
    cell.textLabel.text = [self.dataList[indexPath.row] username];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HostUserModel *hostModel = self.dataList[indexPath.row];

    HXUsermodel *me = [HXUsermodel readSingleModelForKey:nil];
    
    NSString *url = URL_APPLY_FRI.completeURL;
    
    NSString *message = @"你好";
    
    NSDictionary *params = @{@"username":me.username,@"friendUsername":hostModel.username,@"message":message};
    
    [APPHttp postUrl:url params:params target:self.view type:APPHttpTypeSVP success:^(id obj) {
        
        BOOL res = [CoreEaseMob addBuddyWithUsername:hostModel.username message:message];
        
        if(res){
            [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:@"添加成功" duration:1.0 allowEdit:NO beginBlock:nil completeBlock:nil];
        }else{
            [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"添加失败" duration:1.0 allowEdit:NO beginBlock:nil completeBlock:nil];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } errorBlock:nil];
}



@end
