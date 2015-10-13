//
//  EMRotbotChatViewCell.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 15/8/3.
//  Copyright (c) 2015年 dujiepeng. All rights reserved.
//

#import "EMRotbotChatViewCell.h"
#import "EMRobotChatTextBubbleView.h"

@implementation EMRotbotChatViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setMessageModel:(MessageModel *)model
{
    [super setMessageModel:model];
    
    if (model.messageType != eMessageTypeChat) {
        _nameLabel.text = model.nickName;
        _nameLabel.hidden = model.isSender;
    }
    
    _bubbleView.model = self.messageModel;
    [_bubbleView sizeToFit];
}

- (EMChatBaseBubbleView *)bubbleViewForMessageModel:(MessageModel *)messageModel
{
    switch (messageModel.type) {
        case eMessageBodyType_Text:
        {
            return [[EMRobotChatTextBubbleView alloc] init];
        }
            break;
        case eMessageBodyType_Image:
        {
            return [[EMChatImageBubbleView alloc] init];
        }
            break;
        case eMessageBodyType_Voice:
        {
            return [[EMChatAudioBubbleView alloc] init];
        }
            break;
        case eMessageBodyType_Location:
        {
            return [[EMChatLocationBubbleView alloc] init];
        }
            break;
        case eMessageBodyType_Video:
        {
            return [[EMChatVideoBubbleView alloc] init];
        }
            break;
        default:
            break;
    }
    
    return nil;
}

+ (CGFloat)bubbleViewHeightForMessageModel:(MessageModel *)messageModel
{
    switch (messageModel.type) {
        case eMessageBodyType_Text:
        {
            return [EMRobotChatTextBubbleView heightForBubbleWithObject:messageModel];
        }
            break;
        case eMessageBodyType_Image:
        {
            return [EMChatImageBubbleView heightForBubbleWithObject:messageModel];
        }
            break;
        case eMessageBodyType_Voice:
        {
            return [EMChatAudioBubbleView heightForBubbleWithObject:messageModel];
        }
            break;
        case eMessageBodyType_Location:
        {
            return [EMChatLocationBubbleView heightForBubbleWithObject:messageModel];
        }
            break;
        case eMessageBodyType_Video:
        {
            return [EMChatVideoBubbleView heightForBubbleWithObject:messageModel];
        }
            break;
        default:
            break;
    }
    
    return HEAD_SIZE;
}

@end
