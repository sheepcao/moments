//
//  TweetCell.h
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageContentView.h"
#import "PhotosView.h"
#import "CommentsView.h"

@interface TweetCell : UITableViewCell

@property (nonatomic, strong) TweetViewModel *viewModel;

@property (nonatomic, strong) MessageContentView *messageContentView;

@property (nonatomic, strong) PhotosView *photosView;
@property (nonatomic, strong) CommentsView *commentsView;


-(void)setupWithViewModel:(TweetViewModel *)viewModel;
@end
