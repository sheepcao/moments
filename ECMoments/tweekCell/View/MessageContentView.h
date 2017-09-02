//
//  MessageContentView.h
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetViewModel.h"
#import "ECFoldButton.h"

@interface MessageContentView : UIView

@property (strong, nonatomic) ECFoldButton *foldBtn;

-(void)updateContent:(TweetViewModel *)viewModel;
@end
