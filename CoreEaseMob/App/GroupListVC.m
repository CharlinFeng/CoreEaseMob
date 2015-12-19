//
//  GroupListVC.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/12/19.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import "GroupListVC.h"
#import "CoreEaseMobHeader.h"
#import "CoreSVP.h"
#import "EaseMessageViewController.h"

@interface GroupListVC ()<IChatManagerDelegate>

@property (nonatomic,strong) NSArray<EMGroup *> *dataList;

@end


@implementation GroupListVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self fetchGroupList];
    
    [ChatManager addDelegate:self delegateQueue:nil];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加组" style:UIBarButtonItemStylePlain target:self action:@selector(addGroup)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"拉入群" style:UIBarButtonItemStylePlain target:self action:@selector(addMembers)];
    
}


-(void)addMembers{
    
    [CoreEaseMob groupAddOccupants:@[@"test",@"bbb",@"uuu"] toGroup:@"1450511130397" welcomeMessage:nil successBlock:^(EMGroup *group, NSString *welcomeMessage, NSArray *didOccupants) {
        
        CoreSVPSuccess(@"拉入群成功")
        
    } errorBlock:nil];
}


-(void)addGroup{
    
    NSString *name = [NSString stringWithFormat:@"时点:%@",@(self.dataList.count)];
    
    CoreSVPLoading(@"创建中", NO)
    
    [CoreEaseMob groupCreateWithName:name desc:name initInvitees:nil initialWelcomeMessage:nil groupStyle:eGroupStyle_PublicOpenJoin maxMemberCount:100 successBlock:^(EMGroup *group) {
        
        CoreSVPDismiss
        
        CoreSVPSuccess(@"群创建成功")
        
        [self fetchGroupList ];
        
    } errorBlock:^(EMError *error) {
        
        CoreSVPError(@"群创建失败")
    }];
    
}







-(void)didUpdateGroupList:(NSArray *)groupList error:(EMError *)error{

    [self showGroups:groupList];

}



-(void)fetchGroupList{
    
    [CoreEaseMob groupFetchWithSuccessBlock:^(NSArray<EMGroup *> *groups) {
        
        [self showGroups:groups];
        
    } errorBlock:nil];
    
}

-(void)showGroups:(NSArray <EMGroup *> *)groups{
    
    self.dataList = groups;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.dataList == nil) return 0;
    return  self.dataList.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *rid = @"rid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid];

    if(cell == nil){cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:rid];}
        
    cell.textLabel.text = self.dataList[indexPath.row].groupId;
    
    cell.detailTextLabel.text = self.dataList[indexPath.row].groupDescription;
        
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:self.dataList[indexPath.row].groupId conversationType:eConversationTypeGroupChat];
    
    [self.navigationController pushViewController:chatController animated:YES];
}



@end
