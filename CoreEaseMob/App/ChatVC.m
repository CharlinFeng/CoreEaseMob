//
//  ChatVC.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/6.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "ChatVC.h"
#import "CoreSVP.h"
#import "CoreEaseMobHeader.h"
#import "ChatCell.h"
#import "HXUsermodel.h"

@interface ChatVC ()<IEMChatProgressDelegate,IChatManagerDelegate,IEMChatProgressDelegate>

@property (nonatomic,strong) UITextField *tf;

@property (nonatomic,strong) NSMutableArray *dataListM;

@end

@implementation ChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    self.tf = tf;
    tf.placeholder = @"请输入消息";
    self.navigationItem.titleView = tf;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendMsg)];
    
    [CoreEaseMob addChatManagerDelegate:self];

    self.tableView.tableFooterView=[[UIView alloc] init];
}





-(void)sendMsg{
   
    NSString *text = self.tf.text;
    
    if (text.length == 0){
        
        CoreSVPError(@"请输入内容")
        return;
    }

    EMMessage *message = nil;

    if([text isEqualToString:@"图片"]){
        
        message = [CoreEaseMob buildForUsername:self.buddy.username messageBody:[CoreEaseMob messageImg:[UIImage imageNamed:@"1"] displayName:@"小黄人"]];
        
    }else{
        
        //构建消息体
        message = [CoreEaseMob buildForUsername:self.buddy.username messageBody:[CoreEaseMob messageText:self.tf.text]];
    }
    
    
    //发送消息
    [CoreEaseMob sendMessage:message progress:self prepareBlock:^{
        
        NSLog(@"消息发送前的准备");
        
    } completeBlock:^{
        
        CoreSVPSuccess(@"发送成功")
        
    } errorBlock:^(EMError *error) {
        
        CoreSVPError(@"发送失败")
        
    }];
    
    
    
    
    
    HXUsermodel *usermodel = [HXUsermodel readSingleModelForKey:nil];
    
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:[[EMChatText alloc] initWithText:text]];
    message.from = usermodel.username;
    message.to = self.buddy.username;
    body.message = message;
    
    [self.dataListM addObject:body];
    
    [self showData];
}


-(void)setProgress:(float)progress forMessage:(EMMessage *)message forMessageBody:(id<IEMMessageBody>)messageBody{
    NSLog(@"%@",@(progress));
}


-(void)didReceiveMessage:(EMMessage *)message{
    
    NSArray *arr = message.messageBodies;
    EMTextMessageBody *body = arr.firstObject;

    [self.dataListM addObject:body];
    
    [self showData];
}

-(void)showData{
    
    [self.tableView reloadData];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataListM.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}






-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tf endEditing:YES];
}

-(NSMutableArray *)dataListM{
    
    if(_dataListM == nil){
        _dataListM = [NSMutableArray array];
    }
    
    return _dataListM;
}


/** 代理方法区 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataListM.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatCell *cell = [ChatCell cellWithTableView:tableView];
    
    EMTextMessageBody *body = self.dataListM[indexPath.row];
    
    cell.body = body;
    
    cell.isFriend = [body.message.from isEqualToString:self.buddy.username];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    id<IEMMessageBody> body = self.dataListM[indexPath.row];

    if([body isKindOfClass:[EMImageMessageBody class]]){
        
        return 60;
        
    }else{
        
        EMTextMessageBody *textBody = body;
        
        CGFloat height = [textBody.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT)].height + 50;
        
        return height;
    }

}









@end
