//
//  ECImageView.h
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/1/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECImageView : UIImageView
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage ShouldRefresh:(BOOL)shouldRefresh;

@end
