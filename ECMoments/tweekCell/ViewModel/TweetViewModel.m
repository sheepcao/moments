//
//  TweetViewModel.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "TweetViewModel.h"
#import "NSString+Helper.h"

@interface TweetViewModel ()
{
    //    CGRect lastIconFrame;
    //    CGRect lastNameLableFrame;
    //    CGRect lastContentLabelFrame;
    //    CGRect lastMoreButtonFrame;
    //    CGRect lastPhotoContainerViewFrame;
    //    CGRect lastOriginalViewFrame;
}
@property CGFloat labelFoldHeight;


@property (nonatomic) CGFloat contentWidth;

@end
@implementation TweetViewModel
const CGFloat margin = 8;

- (instancetype)initWithTweet:(Tweet *)tweet
{
    self = [super init];
    if (self) {
        self.tweet = tweet;
        self.contentString = self.tweet.content;
        self.senderName = self.tweet.contentSender.nick;
        self.picNamesArray = self.tweet.images;
        self.senderIconUrl = self.tweet.contentSender.avatar;
        self.commentsArray = self.tweet.comments;
        self.errorMessage = self.tweet.error ? self.tweet.error : self.tweet.unknownError;
        
        self.textfont = [UIFont systemFontOfSize:14.5f];
        self.labelFoldHeight = 60;
        
        self.labelStatus = LabelStatusNotSet;
        
        
        
    }
    return self;
}

-(LabelStatus) labelStatus
{
    if (_labelStatus == LabelStatusNotSet) {
        CGFloat contentLabelWidth = self.contentWidth - 2 * margin;
        CGFloat textHeight = [self heightFitContentMessage:self.contentString InWidth:contentLabelWidth];
        if (textHeight <= self.labelFoldHeight) {
            _labelStatus = LabelStatusNoNeedExtend;
        }else
        {
            _labelStatus = LabelStatusFold;
        }
    }
    return _labelStatus;
}

-(CGFloat)moreButtonHeight
{
    return 20 + margin *2;
}

-(CGRect)iconFrame
{
    _iconFrame = CGRectMake(margin, margin, ECSCREEN_W/7, ECSCREEN_W/7);
    
    
    return _iconFrame;
}


-(CGRect)nameLableFrame
{
    CGFloat nameLableX = CGRectGetMaxX(_iconFrame) + margin;
    CGFloat nameLableY = margin;
    _nameLableFrame = CGRectMake(nameLableX, nameLableY, self.contentWidth, 20);
    
    return _nameLableFrame;
}

-(CGRect)contentLabelFrame
{
    
    CGFloat contentLabelX = _nameLableFrame.origin.x;
    CGFloat contentLabelY = CGRectGetMaxY(_nameLableFrame) + margin * 0.5;
    CGFloat contentLabelWidth = self.contentWidth - 2 * margin;
    CGFloat contentLabelHeight = 0;
    CGFloat textHeight = [self heightFitContentMessage:self.contentString InWidth:contentLabelWidth];
    
    
    // set some flag
    switch (self.labelStatus) {
        case LabelStatusUnfold:
            contentLabelHeight = textHeight + self.moreButtonHeight;
            break;
        case LabelStatusFold:
            contentLabelHeight = self.labelFoldHeight + self.moreButtonHeight;
            break;
        case LabelStatusNoNeedExtend:
            contentLabelHeight = textHeight;
            break;
        default:
            break;
    }
    _contentLabelFrame = CGRectMake(contentLabelX, contentLabelY,contentLabelWidth , contentLabelHeight);
    
    
    return _contentLabelFrame;
}

-(CGRect)photoContainerViewFrame
{
    CGFloat photoContainerLabelX = _nameLableFrame.origin.x;
    CGFloat photoContainerLabelY = CGRectGetMaxY(_contentLabelFrame) + margin * 0.5;
    CGFloat photoContainerLabelWidth = _contentLabelFrame.size.width;
    CGFloat photoContainerLabelHeight = 0;
    
    _photoContainerViewFrame = CGRectZero;
    NSInteger count = self.picNamesArray.count;
    
    if (count > 0) {
        
        
        CGFloat photoMargin = 3;
        self.photoWidth = 0;
        if (count == 1) {
            self.photoWidth = photoContainerLabelWidth/2;
        }else
        {
            self.photoWidth = (photoContainerLabelWidth - photoMargin * 4)/3;
        }
        photoContainerLabelHeight = (self.photoWidth + photoMargin)*((count - 1)/3 + 1) + 4 * photoMargin;
        _photoContainerViewFrame = CGRectMake(photoContainerLabelX, photoContainerLabelY, photoContainerLabelWidth, photoContainerLabelHeight);
    }
    
    return _photoContainerViewFrame;
    
}

-(CGRect)commentsViewFrame
{
    CGFloat commentsViewLabelX = _nameLableFrame.origin.x;
    CGFloat commentsViewLabelY = CGRectGetMaxY(_photoContainerViewFrame) + margin * 0.5;
    CGFloat commentsViewLabelWidth = self.contentWidth;
    CGFloat commentsViewLabelHeight = 0;
    
    _commentsViewFrame = CGRectZero;
    
    
    for (Comment *model in self.commentsArray) {
        NSString *wholeComment = [[model.sender.nick stringByAppendingString:@": "] stringByAppendingString:model.commentMsg];
        commentsViewLabelHeight += ([self heightFitContentMessage:wholeComment InWidth:commentsViewLabelWidth] + 6);
    }
    
    _commentsViewFrame = CGRectMake(commentsViewLabelX, commentsViewLabelY, commentsViewLabelWidth, commentsViewLabelHeight);
    
    return _commentsViewFrame;
    
}


-(CGFloat)contentWidth
{
    _contentWidth = ECSCREEN_W - CGRectGetMaxX(self.iconFrame) - 3 * margin;
    
    return _contentWidth;
}
-(CGFloat)heightFitContentMessage:(NSString *)contentMessage InWidth:(CGFloat)width
{
    return [contentMessage sizeWithFont:self.textfont inWidth:width].height;
}

- (CGFloat)cellHeight
{
    CGRect iconFrame = self.iconFrame;
    CGRect nameLableFrame = self.nameLableFrame;
    CGRect contentLabelFrame = self.contentLabelFrame;
    CGRect photoContainerViewFrame = self.photoContainerViewFrame;
    CGRect commentsViewFrame = self.commentsViewFrame;
    
    ECLog(@"iconFrame.y: %f - nameLableFrame.y: %f - contentLabelFrame.y: %f - photoContainerViewFrame.y: %f - ",iconFrame.origin.y,nameLableFrame.origin.y,contentLabelFrame.origin.y,photoContainerViewFrame.origin.y);
    
    return CGRectGetMaxY(commentsViewFrame) + margin * 2;
    
}





@end
