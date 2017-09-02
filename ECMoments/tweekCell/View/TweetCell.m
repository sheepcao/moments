//
//  TweetCell.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "TweetCell.h"
#import "ECImageView.h"
@interface TweetCell()

@property (strong, nonatomic)  ECImageView *avatarImageView;
@property (strong, nonatomic)  UILabel *nameLabel;

@end
@implementation TweetCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initialSetup];
    }
    return self;
}

- (void)initialSetup
{
    self.avatarImageView = [[ECImageView alloc] init];
    self.nameLabel = [[UILabel alloc] init];
    self.messageContentView = [[MessageContentView alloc] init];
    self.photosView = [[PhotosView alloc] init];
    
    [self addSubview:self.avatarImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.messageContentView];
    [self addSubview:self.photosView];

}

-(void)setupWithViewModel:(TweetViewModel *)viewModel
{
    [self.avatarImageView setFrame:viewModel.iconFrame];
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:viewModel.senderIconUrl] placeholderImage:[UIImage imageNamed:@"avatar"] ShouldRefresh:NO];
    
    [self.nameLabel setFrame:viewModel.nameLableFrame];
    [self.nameLabel setText:viewModel.senderName];
    [self.nameLabel setTextColor:EC_RGBColor(68,84,121)];
    
    [self.messageContentView updateContent:viewModel];
    [self.photosView updateContent:viewModel];
    
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawLineFrom:CGPointMake(0, self.height-1) ToPoint:CGPointMake(self.width, self.height -1)];
    
    
}



-(void)drawLineFrom:(CGPoint)start ToPoint:(CGPoint)end
{
    UIColor *color = [UIColor lightGrayColor];
    [color setStroke];
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    linePath.lineWidth = 0.3f;
    [linePath moveToPoint:start];
    [linePath addLineToPoint:end];
    [linePath stroke];
    
}
@end
