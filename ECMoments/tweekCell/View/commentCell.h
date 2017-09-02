//
//  commentCell.h
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface commentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
-(void)setupWithModel:(Comment *)commentModel;

@end
