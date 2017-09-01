//
//  Tweet.h
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/1/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ContentSender : NSObject
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *nick;
@property (nonatomic,strong) NSString *avatar;

@end

@interface Comment : NSObject
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) ContentSender *sender;
@end

@interface TweetImage : NSObject
@property (nonatomic,strong) NSString *url;
@end


@interface Tweet : NSObject

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) ContentSender *contentSender;
@property (nonatomic,strong) NSArray *comments;
@property (nonatomic,strong) NSString *error;
@property (nonatomic,strong) NSString *unknownError;

@end


