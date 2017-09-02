//
//  MomentsHeaderView.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "MomentsHeaderView.h"
#import "ECImageView.h"
@interface MomentsHeaderView()

@property(nonatomic,strong) ECImageView *profileImageView;
@property(nonatomic,strong) ECImageView *avatarView;
@property(nonatomic,strong) UILabel *nameLabel;

@end

@implementation MomentsHeaderView

-(ECImageView *)profileImageView
{
    if (!_profileImageView) {
        _profileImageView = [[ECImageView alloc] init];
    }
    return _profileImageView;
}

-(ECImageView *)avatarView
{
    if (!_avatarView) {
        _avatarView = [[ECImageView alloc] init];
    }
    return _avatarView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setupProfileImageWithURL:(NSURL *)url PlaceholderImage:(UIImage *)placeImage ShouldRefresh:(BOOL)shouldRefresh
{
    [self.profileImageView setImageWithURL:url placeholderImage:placeImage ShouldRefresh:shouldRefresh];
    CGFloat ratio = self.profileImageView.image.size.width/self.profileImageView.image.size.height;
    self.profileImageView.contentMode = UIViewContentModeScaleToFill;
    
    self.profileImageView.width = self.width;
    self.profileImageView.height = self.width / ratio;
    
    self.profileImageView.x = 0;
    self.profileImageView.y = MIN(0, self.height - self.profileImageView.height - 20);
    
    
    [self addSubview:self.profileImageView];
    
    
}
- (void)setupAvatarWithURL:(NSURL *)url PlaceholderImage:(UIImage *)placeImage ShouldRefresh:(BOOL)shouldRefresh
{
    self.avatarView.layer.borderWidth = 1.5f;
    self.avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    [self.avatarView setImageWithURL:url placeholderImage:placeImage ShouldRefresh:shouldRefresh];
    
    
    self.avatarView.contentMode = UIViewContentModeScaleToFill;
    
    
    self.avatarView.x = self.width - 100;
    self.avatarView.y = self.height - 70;
    self.avatarView.width = 70;
    self.avatarView.height = 70;
    
    [self addSubview:self.avatarView];
    
}
- (void)setupNickName:(NSString *)nickName
{
    self.nameLabel.text = nickName;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    self.nameLabel.font = [UIFont boldSystemFontOfSize:15];
    
    self.nameLabel.shadowColor = [UIColor darkGrayColor];
    self.nameLabel.shadowOffset = CGSizeMake(1.5, 1.5);
    
    self.nameLabel.width = 200;
    self.nameLabel.height = 20;
    self.nameLabel.x = self.width - self.nameLabel.width - 110;
    self.nameLabel.y = self.height - 20 - 20 - 6;
    
    [self addSubview:self.nameLabel];
    
}

@end
