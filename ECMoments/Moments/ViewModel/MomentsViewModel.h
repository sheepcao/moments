//
//  MomentsViewModel.h
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfile.h"
@interface MomentsViewModel : NSObject

//@property(nonatomic,strong) UserProfile *profile;
@property(nonatomic,strong) NSArray *tweetsToShow;
@property(nonatomic,strong) NSArray *allTweetsModels;

-(void)loadUserProfileWithBlock:(void(^)(NSError *error ,UserProfile *profile))block;

- (void)loadTweetsWithCount:(NSInteger)count WithBlock:(void(^)(NSError *error))block;
-(void)loadAllTweetsWithBlock:(void(^)(NSError *error))block;
@end
