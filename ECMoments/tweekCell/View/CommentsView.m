//
//  CommentsView.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "CommentsView.h"
#import "commentCell.h"

@interface CommentsView ()
@property (nonatomic, strong) NSArray *commentsArray;

@end

@implementation CommentsView
static NSString * const CellIdentifier = @"commentCellIdentifier";

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.userInteractionEnabled = NO;

    
//    [self registerClass:[commentCell class] forCellReuseIdentifier:CellIdentifier];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = NO;
    self.estimatedRowHeight = 30;
    self.rowHeight = UITableViewAutomaticDimension;

    self.backgroundColor = [UIColor clearColor];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection comment");
    return self.commentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"comment cellForRowAtIndexPath: %lu",indexPath.row);
    
    Comment *commentModel = [self.commentsArray objectAtIndex:indexPath.row];
    
    commentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"commentCell" owner:self options:nil] lastObject];
    }
    
    [cell setupWithModel:commentModel];

    return cell;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    TweetViewModel *cellModel = [self.momentsViewModel.tweetsToShow objectAtIndex:indexPath.row];
//    return cellModel.cellHeight;
//}

-(void)updateContent:(TweetViewModel *)viewModel
{
    [self setFrame:viewModel.commentsViewFrame];
    
    self.commentsArray = [NSArray arrayWithArray:viewModel.commentsArray];
    [self reloadData];
    
}

@end
