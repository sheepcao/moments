//
//  TweetViewModel.h
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweet.h"

typedef NS_ENUM(NSInteger,LabelStatus)
{
    LabelStatusNotSet,
    LabelStatusNoNeedExtend,
    LabelStatusFold,
    LabelStatusUnfold
    
};

@interface TweetViewModel : NSObject


@property (nonatomic, strong) Tweet *tweet;

@property (nonatomic, strong) NSString *contentString;
@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSArray *picNamesArray;
@property (nonatomic, strong) NSString *senderIconUrl;
@property (nonatomic, strong) NSArray *commentsArray;
@property (nonatomic, strong) NSString *errorMessage;

@property (nonatomic) LabelStatus labelStatus;
@property (nonatomic, assign) CGFloat cellHeight;


@property (nonatomic, strong) UIFont *textfont;

@property (nonatomic) CGRect iconFrame;
@property (nonatomic) CGRect nameLableFrame;
@property (nonatomic) CGRect contentLabelFrame;
@property (nonatomic) CGFloat moreButtonHeight;
@property (nonatomic) CGRect photoContainerViewFrame;
@property (nonatomic) CGFloat photoWidth;
@property (nonatomic) CGRect commentsViewFrame;




- (instancetype)initWithTweet:(Tweet *)tweet;


@end
