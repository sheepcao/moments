//
//  UserProfile.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile
+ (NSDictionary *)modelCustomPropertyMapper {
    NSDictionary *dic=@{@"profileImage" :@"profile-image"};
    return dic;
}
@end
