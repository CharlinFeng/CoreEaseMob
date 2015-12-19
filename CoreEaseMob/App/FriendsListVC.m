//
//  FrendsListTVC.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "FriendsListVC.h"
#import "HXUsermodel.h"
#import "CoreSVP.h"
#import "SearchView.h"
#import "SearchListVC.h"
#import "NSString+AppURL.h"
#import "HostUserModel.h"
#import "CoreAleetViewManagerVC.h"
#import "ChatVC.h"
#import "EaseUI.h"
#import "GroupListVC.h"

@interface FriendsListVC ()<IChatManagerDelegate>

@property (nonatomic,strong) NSArray *dataList;

@end

@implementation FriendsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"好友";
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"退出登陆" style:UIBarButtonItemStylePlain target:self action:@selector(loginOut)];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"群组列表" style:UIBarButtonItemStylePlain target:self action:@selector(groupListVC)];
    
    self.navigationItem.rightBarButtonItems = @[item1, item2    ];
    
    
    SearchView *view = [SearchView searchView];
    
    self.navigationItem.titleView = view;
    
    view.SearchAction = ^(NSString *str){
        
        if(str.length ==0 ){
            [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"请输入内容" duration:2.0 allowEdit:NO beginBlock:nil completeBlock:nil];
            return;
        }
        
        [self getdata:str];

    };
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [CoreEaseMob addChatManagerDelegate:self];
    
    [self handleBuddyRequest];
    
    [self blockList];
}

-(void)dealloc{
    [CoreEaseMob removeChatManagerDelegate:self];
}



-(void)groupListVC{
    
    GroupListVC *glvc = [[GroupListVC alloc] init];
    
    [self.navigationController pushViewController:glvc animated:YES];
}




/** 获取黑名单 */
-(void)blockList{
    
    [CoreEaseMob fetchBlockedListWithCompletionBlock:^(NSArray *blockedList) {
        
        
    } errorBlock:^{
        NSLog(@"获取黑名单出错");
    }];
}


-(void)handleBuddyRequest{
    
    NSArray *buddyRequest = CoreEaseMobInstance.buddyRequests;
    
    //处理请求
    [buddyRequest enumerateObjectsUsingBlock:^(BuddyRequestModel *m, NSUInteger idx, BOOL *stop) {
        
        [CoreEaseMob handleBuddyRequest:m.username isAccept:YES rejectReason:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self fetch];
        });
    }];
}



-(void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message{
    
    [self handleBuddyRequest];

    [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:@"好友添加成功" duration:1 allowEdit:NO beginBlock:nil completeBlock:nil
     ];
}



-(void)didRemovedByBuddy:(NSString *)username{
    
    [CoreEaseMob removeBuddyWithUsername:username removeFromRemote:YES];
    
    [CoreSVP showSVPWithType:CoreSVPTypeNone Msg:[NSString stringWithFormat:@"您已经被%@删除",username] duration:2.0 allowEdit:NO beginBlock:nil completeBlock:nil];
    
    [self fetch];
}





-(void)didAcceptedByBuddy:(NSString *)username{
    
    NSString *msg = [NSString stringWithFormat:@"%@同意添加您为好友",username];
    
    [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:msg duration:2.0 allowEdit:NO beginBlock:nil completeBlock:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self fetch];
    });
}




-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self fetch];
}





-(void)getdata:(NSString *)str{
    
    NSString *url = URL_SEARCH.completeURL;
    
    NSDictionary *params = @{@"keyword":str};
    
    [APPHttp postUrl:url params:params target:nil type:APPHttpTypeNone success:^(id obj) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSArray *hostModels = [HostUserModel objectArrayWithKeyValuesArray:obj];
            
            SearchListVC *searchTVC = [[SearchListVC alloc] init];
            
            searchTVC.dataList = hostModels;
            
            [self.navigationController pushViewController:searchTVC animated:YES];
            
        });
        
    } errorBlock:nil];

}



/** 获取好友列表 */
-(void)fetch{

    dispatch_async(dispatch_get_main_queue(), ^{
        [CoreEaseMob fetchBuddyList:^(NSArray *buddyList) {
            
            if(buddyList.count == 0){
                
                [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:@"0个好友" duration:1.0 allowEdit:NO beginBlock:nil completeBlock:nil];
            }
            
            self.dataList = buddyList;
            
            [self.tableView reloadData];
            
        }];
    });
}


-(void)loginOut{
    
    [CoreEaseMob loginOffWithUnbindDeviceToken:YES completionBlock:^(NSDictionary *info) {
        
        [HXUsermodel saveSingleModel:nil forKey:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(self.dataList == nil) return 0;
    
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *rid = @"FriendsListVC";

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    
    cell.textLabel.text = [self.dataList[indexPath.row] username];

    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EMBuddy *buddy = self.dataList[indexPath.row];

    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:buddy.username conversationType:eConversationTypeChat];
    
    [self.navigationController pushViewController:chatController animated:YES];
}


-(void)changeRel:(NSIndexPath *)indexPath{
    [CoreAleetViewManagerVC showWithAleetViewType:CoreAleetViewTypeUIActionSheet inController:self title:@"请选择" message:@"请选择" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"删除好友",@"拉黑好友"] clickedButtonBlock:^(NSInteger index) {
        
        HXUsermodel *me = [HXUsermodel readSingleModelForKey:nil];
        
        EMBuddy *buddy = self.dataList[indexPath.row];
        
//        if(index == 0){ //删除
        
            NSString *url=URL_DELETE_FRI.completeURL;
            
            NSDictionary *params = @{@"username": me.username,@"friendUsername": buddy.username,@"removeFromRemote":@(1)};
            
            [APPHttp postUrl:url params:params target:nil type:APPHttpTypeSVP success:^(id obj) {
                
                
                BOOL res = [CoreEaseMob removeBuddyWithUsername:buddy.username removeFromRemote:YES];
                
                if(res){
                    
                    [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:@"删除成功" duration:1.0 allowEdit:NO beginBlock:nil completeBlock:nil];
                    
                    [self fetch];
                    
                }else{
                    
                    [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"删除失败" duration:1.0 allowEdit:NO beginBlock:nil completeBlock:nil];
                    
                }
                
                
                
            } errorBlock:nil];
            
//        }else{//拉黑
//            
//            
//            NSString *url=URL_HANDLE_FRI.completeURL;
//            
//            NSDictionary *params = @{@"username": me.username,@"friendUsername": buddy.username,@"dealType":@(1)};
//            
//            [APPHttp postUrl:url params:params target:nil type:APPHttpTypeSVP success:^(id obj) {
//                
//                [CoreEaseMob blockBuddyWithUsername:buddy.username relationship:eRelationshipBoth];
//                
//                [CoreSVP showSVPWithType:CoreSVPTypeSuccess Msg:@"拉黑成功" duration:1.0 allowEdit:NO beginBlock:nil completeBlock:nil];
//                
//                [self fetch];
//                
//            } errorBlock:nil];
//            
//        }
//
        
        
        
    }];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.navigationController.navigationBar endEditing:YES];
}


@end
