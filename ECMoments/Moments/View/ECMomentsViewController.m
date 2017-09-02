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

@interface ECMomentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) MomentsViewModel *momentsViewModel;
@property (nonatomic,strong) TweetCell *prototypeCell;

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
    // Do any additional setup after loading the view, typically from a nib.
    ECWeakSelf(weakSelf);
    [self setupTableView];
    [self.momentsViewModel loadUserProfileWithBlock:^(NSError *error, UserProfile *profile) {
        ECStrongSelf(strongSelf);
        
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
