//
//  MessageContentView.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "MessageContentView.h"

@interface MessageContentView()

@property (strong, nonatomic) UILabel *contentLabel;

@end

@implementation MessageContentView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.numberOfLines = 0;

    self.foldBtn = [[ECFoldButton alloc] init];
    [self addSubview:self.contentLabel];
    [self addSubview:self.foldBtn];
    
}



-(void)updateContent:(TweetViewModel *)viewModel
{
    [self setFrame:viewModel.contentLabelFrame];
    CGFloat contentHeight = 0;
    CGFloat buttonHeight = 0;
    
    NSString *title = @"";

    switch (viewModel.labelStatus) {
        case LabelStatusNoNeedExtend:
            contentHeight = self.height;
            break;
        case LabelStatusFold:
            title = @"全文";
            buttonHeight = viewModel.moreButtonHeight;
            contentHeight = self.height - buttonHeight;
            break;
        case LabelStatusUnfold:
            title = @"收起";
            buttonHeight = viewModel.moreButtonHeight;
            contentHeight = self.height - buttonHeight;
            break;
        default:

            break;
    }
    self.contentLabel.height = self.height - viewModel.moreButtonHeight;
    self.contentLabel.width = self.width;
    self.contentLabel.y = 0;
//    [self.contentLabel setFrame:CGRectMake(0, 0, self.width, self.height - viewModel.moreButtonHeight)];
    [self.foldBtn setFrame:CGRectMake(0, self.height - buttonHeight, 40, buttonHeight)];
    
    [self.contentLabel setText:viewModel.contentString];
    [self.foldBtn setTitle:title forState:UIControlStateNormal];
    self.contentLabel.font = viewModel.textfont;

}


@end
