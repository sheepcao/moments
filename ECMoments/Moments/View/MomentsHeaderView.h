//
//  MomentsHeaderView.h
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MomentsHeaderView : UIView
- (void)setupProfileImageWithURL:(NSURL *)url PlaceholderImage:(UIImage *)placeImage ShouldRefresh:(BOOL)shouldRefresh;
- (void)setupAvatarWithURL:(NSURL *)url PlaceholderImage:(UIImage *)placeImage ShouldRefresh:(BOOL)shouldRefresh;
- (void)setupNickName:(NSString *)nickName;

@end
