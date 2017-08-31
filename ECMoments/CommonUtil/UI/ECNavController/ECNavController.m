//
//  ECNavController.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 8/31/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "ECNavController.h"

@interface ECNavController ()

@end

@implementation ECNavController

+ (void)initialize
{
    // 设置导航栏的主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:EC_RGBColor(200, 28, 30)];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:EC_RGBColor(230, 230, 230) forKey:NSForegroundColorAttributeName];
    navBar.titleTextAttributes = dict;
    navBar.tintColor = EC_RGBColor(200, 200, 200);
    
}


@end
