//
//  ECMacro.h
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 8/31/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#ifndef ECMacro_h
#define ECMacro_h

/** log*/
#ifdef DEBUG
#define ECLog(...) NSLog(__VA_ARGS__)
#else
#define ECLog(...)
#endif

/** color */

#define EC_RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]


/** weak & strong */
#define ECWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define ECStrongSelf(strongSelf) __strong __typeof(&*self)strongSelf = weakSelf;

#endif /* ECMacro_h */

