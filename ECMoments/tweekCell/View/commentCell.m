//
//  commentCell.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/2/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "commentCell.h"

@implementation commentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupWithModel:(Comment *)commentModel
{
    [self.commentLabel setAttributedText:[self generateAttributedStringWithCommentItemModel:commentModel]];
    [self.commentLabel sizeToFit];
}

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(Comment *)model
{
    NSString *text = model.sender.nick;
   
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.commentMsg]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14.5f]} ];
    UIColor *highLightColor = EC_RGBColor(68,84,121);
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor ,NSFontAttributeName :[UIFont systemFontOfSize:14.5f]} range:[text rangeOfString:model.sender.nick]];
   
    return attString;
}


@end
