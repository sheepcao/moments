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
#import "MJRefresh/MJRefresh.h"

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
    [self addRefresher];
    
    [self.momentsViewModel loadUserProfileWithBlock:^(NSError *error, UserProfile *profile) {
        ECStrongSelf(strongSelf);
        [strongSelf setupHeadViewWithProfile:profile];
        
    }];
    
    
    
}
- (void)setupTableView {
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.tableview registerClass:[TweetCell class] forCellReuseIdentifier:CellIdentifier];
    MomentsHeaderView *headerView = [[MomentsHeaderView alloc] init];
    headerView.frame = CGRectMake(0, -64, self.view.width, 260);
    
    self.headerView = headerView;
    self.tableview.tableHeaderView = headerView;
}


- (void)setupHeadViewWithProfile:(UserProfile *)profile
{
    
    [self.headerView setupProfileImageWithURL:[NSURL URLWithString:profile.profileImage] PlaceholderImage:[UIImage imageNamed:@"me"] ShouldRefresh:NO];
    [self.headerView setupAvatarWithURL:[NSURL URLWithString:profile.avatar] PlaceholderImage:[UIImage imageNamed:@"me"] ShouldRefresh:NO];
    [self.headerView setupNickName:profile.nick];
    
}


-(void)addRefresher
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.ignoredScrollViewContentInsetTop = -64;
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    // 设置文字
    [header setTitle:@"Pull down to refresh!!!!!!!!" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor whiteColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置刷新控件
    self.tableview.mj_header = header;
    self.tableview.mj_header.y += 124;
    [self.tableview bringSubviewToFront:self.tableview.mj_header];
    
    
}


-(void)loadNewData
{
    ECWeakSelf(weakSelf);
    [self.momentsViewModel loadTweetsWithCount:5 WithBlock:^(NSError *error) {
        ECStrongSelf(strongSelf);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [strongSelf.tableview reloadData];
            [strongSelf.tableview.mj_header endRefreshing];
            
            if (!strongSelf.tableview.mj_footer) {
                strongSelf.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    [strongSelf loadMoreData];
                }];
            }
       
        });
        
    }];
    
    

}

-(void)loadMoreData
{
    
    NSInteger amount = self.momentsViewModel.tweetsToShow.count;
    amount = amount + 5;
    ECLog(@"amount - %lu",amount);
    ECWeakSelf(weakSelf);
    [self.momentsViewModel loadTweetsWithCount:amount WithBlock:^(NSError *error) {
        ECStrongSelf(strongSelf);
        ECLog(@"reloadData - %lu",amount);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [strongSelf.tableview reloadData];
            ECLog(@"endRefreshing - %lu",amount);
            [strongSelf.tableview.mj_footer endRefreshing];
            
            if (amount >= strongSelf.momentsViewModel.allTweetsModels.count) {
                [strongSelf.tableview.mj_footer removeFromSuperview];
                strongSelf.tableview.mj_footer = nil;
            }
        });
        
        
    }];

    
  
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
    ECLog(@"%lu.cellHeight = %f",indexPath.row,cellModel.cellHeight);
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
