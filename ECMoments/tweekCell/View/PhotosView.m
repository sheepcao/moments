//
//  PhotosView.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "PhotosView.h"
#import "ECImageView.h"

const int rowMax = 3;
const int collumMax = 3;
const int photoMargin = 3;

@implementation PhotosView


//- (instancetype)init
//{
//    if (self = [super init]) {
//        [self setupSubviews];
//    }
//    return self;
//}
//
//- (void)setupSubviews
//{

//}


-(void)updateContent:(TweetViewModel *)viewModel;
{

    if (viewModel.picNamesArray.count < 1) {
        return ;
    }
    
    [self setFrame:viewModel.photoContainerViewFrame];
    for (UIView *imageView in self.subviews) {
        if ([imageView isKindOfClass:[ECImageView class]]) {
            [imageView removeFromSuperview];
        }
    }
    for (int i = 0; i < viewModel.picNamesArray.count; i++) {
        ECImageView *imageView = [[ECImageView alloc] init];
        
        NSInteger row = i / rowMax;
        NSInteger col = i % collumMax;
        // 间距
        CGFloat margin = photoMargin;
        CGFloat photoWidth = viewModel.photoWidth;
        // PointX
        CGFloat picX = margin + (photoWidth + margin) * col;
        // PointY
        CGFloat picY = margin + (photoWidth + margin) * row;
        
        // 图片的frame
        imageView.frame = CGRectMake(picX, picY, photoWidth, photoWidth);
        
        [imageView setImageWithURL:[NSURL URLWithString:[(TweetImage *)viewModel.picNamesArray[i] url]] placeholderImage:[UIImage imageNamed:@"404"] ShouldRefresh:NO];
        
        [self addSubview:imageView];
        
    }
    
}


@end
