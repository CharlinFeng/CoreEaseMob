/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */


#import "UIImageView+HeadImage.h"

#import "UserProfileManager.h"
#import "UIImageView+EMWebCache.h"

@implementation UIImageView (HeadImage)

- (void)imageWithUsername:(NSString *)username placeholderImage:(UIImage*)placeholderImage
{
    if (placeholderImage == nil) {
        placeholderImage = [UIImage imageNamed:@"chatListCellHead"];
    }
    UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:username];
    if (profileEntity) {
        [self sd_setImageWithURL:[NSURL URLWithString:profileEntity.imageUrl] placeholderImage:placeholderImage];
    } else {
        [self sd_setImageWithURL:nil placeholderImage:placeholderImage];
    }
}

@end

@implementation UILabel (Prase)

- (void)setTextWithUsername:(NSString *)username
{
    UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:username];
    if (profileEntity) {
        if (profileEntity.nickname && profileEntity.nickname.length > 0) {
            [self setText:profileEntity.nickname];
            [self setNeedsLayout];
        } else {
            [self setText:username];
        }
    } else {
        [self setText:username];
    }
    
}

@end
