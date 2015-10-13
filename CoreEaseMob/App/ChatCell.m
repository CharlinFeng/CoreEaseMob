//
//  ChatCell.m
//  CoreEaseMob
//
//  Created by 冯成林 on 15/9/8.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "ChatCell.h"
#import "UIImageView+SD.h"


@interface ChatCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;




@end



@implementation ChatCell






+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *rid = @"ChatCell";
    
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil) cell = [[NSBundle mainBundle] loadNibNamed:rid owner:nil options:nil].lastObject;
    
    return cell;
}



-(void)setBody:(id<IEMMessageBody>)body{
    
    _body = body;
    
    if(eMessageBodyType_Text == body.messageBodyType){ //文字
        EMTextMessageBody *textBody = body;
        
        _msgLabel.text = textBody.text;
    }else if(eMessageBodyType_Image == body.messageBodyType){//图片
        
        EMImageMessageBody *imageBody = body;
        [_imgV imageWithUrlStr:imageBody.remotePath size:CGSizeMake(60, 60) scale:0.3];
    }
    
    _nameLabel.text = body.message.from;

}


-(void)setIsFriend:(BOOL)isFriend{
    
    _isFriend = isFriend;
    
    UIColor *color = isFriend ? [UIColor redColor]:[UIColor greenColor];
    
    _nameLabel.textColor = color;
}



@end
