//
//  ViewController.m
//  ECMoments
//
//  Created by EricCao on 8/31/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "ECMomentsViewController.h"
#import "TweetCell.h"
#import "MomentsViewModel.h"
#import "MomentsHeaderView.h"

@interface ECMomentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) MomentsViewModel *momentsViewModel;
@property (nonatomic,strong) TweetCell *prototypeCell;
@property(nonatomic,strong) MomentsHeaderView *headerView;

@end


@implementation ECMomentsViewController

static NSString * const CellIdentifier = @"TweetCell";
- (MomentsViewModel *)momentsViewModel {
    if (_momentsViewModel == nil) {
        _momentsViewModel = [[MomentsViewModel alloc] init];
    }
    return _momentsViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    // Do any additional setup after loading the view, typically from a nib.
    ECWeakSelf(weakSelf);
    [self setupTableView];
    [self.momentsViewModel loadUserProfileWithBlock:^(NSError *error, UserProfile *profile) {
        ECStrongSelf(strongSelf);
        [strongSelf setupHeadViewWithProfile:profile];
        
    }];
    [self.momentsViewModel loadTweetsWithCount:5 WithBlock:^(NSError *error) {
        ECStrongSelf(strongSelf);
        [strongSelf.tableview reloadData];
    }];
    
}
- (void)setupTableView {
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.tableview registerClass:[TweetCell class] forCellReuseIdentifier:CellIdentifier];
    
}

- (void)setupHeadViewWithProfile:(UserProfile *)profile
{
    
    MomentsHeaderView *headerView = [[MomentsHeaderView alloc] init];
    headerView.frame = CGRectMake(0, -64, self.view.width, 260);
    [headerView setupProfileImageWithURL:[NSURL URLWithString:profile.profileImage] PlaceholderImage:[UIImage imageNamed:@"me"] ShouldRefresh:NO];
    [headerView setupAvatarWithURL:[NSURL URLWithString:profile.avatar] PlaceholderImage:[UIImage imageNamed:@"me"] ShouldRefresh:NO];
    [headerView setupNickName:profile.nick];
    
    self.headerView = headerView;
    self.tableview.tableHeaderView = headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection");
    return self.momentsViewModel.tweetsToShow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath: %lu",indexPath.row);
    
    TweetViewModel *cellModel = [self.momentsViewModel.tweetsToShow objectAtIndex:indexPath.row];
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell setupWithViewModel:cellModel];
    if (cell.messageContentView.foldBtn.height > 0.01) {
        cell.messageContentView.foldBtn.buttonInindexPath = indexPath;
        [cell.messageContentView.foldBtn addTarget:self action:@selector(foldTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetViewModel *cellModel = [self.momentsViewModel.tweetsToShow objectAtIndex:indexPath.row];
    return cellModel.cellHeight;
}

-(void)foldTap:(ECFoldButton *)sender
{
    ECLog(@"tappppp:%lu",sender.buttonInindexPath.row);
    TweetViewModel *cellModel = [self.momentsViewModel.tweetsToShow objectAtIndex:sender.buttonInindexPath.row];
    if (cellModel.labelStatus == LabelStatusFold) {
        cellModel.labelStatus = LabelStatusUnfold;
    }else if (cellModel.labelStatus == LabelStatusUnfold) {
        cellModel.labelStatus = LabelStatusFold;
    }
//    [self.tableview reloadRowsAtIndexPaths:@[sender.buttonInindexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableview reloadData];
}


@end
