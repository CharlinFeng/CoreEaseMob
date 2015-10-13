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

#import "GroupBansViewController.h"

#import "ContactView.h"
#import "EMGroup.h"

#define kColOfRow 5
#define kContactSize 60

@interface GroupBansViewController ()<IChatManagerDelegate>
{
    BOOL _isEditing;
}

@property (strong, nonatomic) EMGroup *group;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPress;
@property (nonatomic) BOOL isUpdate;

@end

@implementation GroupBansViewController

@synthesize group = _group;
@synthesize scrollView = _scrollView;
@synthesize longPress = _longPress;
@synthesize isUpdate = _isUpdate;

- (instancetype)initWithGroup:(EMGroup *)group
{
    self = [self init];
    if (self) {
        _group = group;
        _isEditing = NO;
        _isUpdate = NO;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"title.groupBlackList", @"Group black list");
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    [self.view addSubview:self.scrollView];
    [self fetchGroupBans];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, kContactSize)];
        _scrollView.tag = 0;
        _scrollView.backgroundColor = [UIColor clearColor];
        
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        _longPress.minimumPressDuration = 0.5;
        [_scrollView addGestureRecognizer:_longPress];
    }
    
    return _scrollView;
}

#pragma mark - action

- (void)back
{
    if (_isUpdate) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupBansChanged" object:nil];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapView:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        if (_isEditing) {
            [self setScrollViewEditing:NO];
            _isEditing = NO;
        }
    }
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        if (!_isEditing) {
            [self setScrollViewEditing:YES];
            _isEditing = YES;
        }
    }
}

- (void)setScrollViewEditing:(BOOL)isEditing
{
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    
    for (ContactView *contactView in self.scrollView.subviews)
    {
        if ([contactView isKindOfClass:[ContactView class]]) {
            if ([contactView.remark isEqualToString:loginUsername]) {
                continue;
            }
            
            [contactView setEditing:isEditing];
        }
    }
}

#pragma mark - other

- (void)refreshScrollView
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.scrollView removeGestureRecognizer:_longPress];
    
    int tmp = (int)([_group.bans count] + 1) % kColOfRow;
    int row = (int)([_group.bans count] + 1) / kColOfRow;
    row += tmp == 0 ? 0 : 1;
    self.scrollView.tag = row;
    self.scrollView.frame = CGRectMake(10, 20, self.view.frame.size.width - 20, row * kContactSize);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, row * kContactSize);
    
    if ([_group.bans count] == 0) {
        return;
    }
    
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    
    int i = 0;
    int j = 0;
    for (i = 0; i < row; i++) {
        for (j = 0; j < kColOfRow; j++) {
            NSInteger index = i * kColOfRow + j;
            if (index < [_group.bans count]) {
                NSString *username = [_group.bans objectAtIndex:index];
                ContactView *contactView = [[ContactView alloc] initWithFrame:CGRectMake(j * kContactSize, i * kContactSize, kContactSize, kContactSize)];
                contactView.index = i * kColOfRow + j;
                contactView.image = [UIImage imageNamed:@"chatListCellHead.png"];
                contactView.remark = username;
                if (![username isEqualToString:loginUsername]) {
                    contactView.editing = _isEditing;
                }
                
                __weak typeof(self) weakSelf = self;
                [contactView setDeleteContact:^(NSInteger index) {
                    weakSelf.isUpdate = YES;
                    [weakSelf showHudInView:weakSelf.view hint:NSLocalizedString(@"group.ban.removing", @"members are removing from the blacklist...")];
                    NSArray *occupants = [NSArray arrayWithObject:[weakSelf.group.bans objectAtIndex:index]];
                    [[EaseMob sharedInstance].chatManager asyncUnblockOccupants:occupants forGroup:weakSelf.group.groupId completion:^(EMGroup *group, EMError *error) {
                        [weakSelf hideHud];
                        if (!error) {
                            weakSelf.group = group;
                            [weakSelf refreshScrollView];
                        }
                        else{
                            [weakSelf showHint:error.description];
                        }
                    } onQueue:nil];
                }];
                
                [self.scrollView addSubview:contactView];
            }
        }
    }
}

- (void)fetchGroupBans
{
    __weak typeof(self) weakSelf = self;
    [self showHudInView:weakSelf.view hint:NSLocalizedString(@"group.ban.fetching", @"getting group blacklist...")];
    [[EaseMob sharedInstance].chatManager asyncFetchGroupBansList:_group.groupId completion:^(NSArray *groupBans, EMError *error) {
        [weakSelf hideHud];
        if (!error) {
            [weakSelf refreshScrollView];
        }
        else{
            NSString *errorStr = [NSString stringWithFormat:NSLocalizedString(@"group.ban.fetchFail", @"fail to get blacklist: %@"), error.description];
            [weakSelf showHint:errorStr];
        }
    } onQueue:nil];
}

@end
