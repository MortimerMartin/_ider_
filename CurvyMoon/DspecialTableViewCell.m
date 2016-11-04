//
//  DspecialTableViewCell.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DspecialTableViewCell.h"
#import "substitute.h"
@implementation DspecialTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSub:(substitute *)sub{
    _sub = sub;
    [self.godimg sd_setImageWithURL:[NSURL URLWithString:sub.cover] placeholderImage:[UIImage imageNamed:@"qingxin.jpg"]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
