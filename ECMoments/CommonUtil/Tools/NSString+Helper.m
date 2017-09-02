//
//  NSString+Helper.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)
- (CGSize)sizeWithFont:(UIFont *)font inWidth:(CGFloat)width
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
}
@end
