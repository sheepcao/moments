//
//  PhotosView.h
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetViewModel.h"

@interface PhotosView : UIView
-(void)updateContent:(TweetViewModel *)viewModel;

@end
