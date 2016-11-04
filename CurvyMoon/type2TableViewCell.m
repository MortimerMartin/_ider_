//
//  type2TableViewCell.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "type2TableViewCell.h"

#import "RCModel.h"
@implementation type2TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRcmodel:(RCModel *)rcmodel{
    _rcmodel = rcmodel;
    [self.godimg sd_setImageWithURL:[NSURL URLWithString:rcmodel.cover] placeholderImage:nil];
}


//cell上控件绑定内容
-(void)bandingstatus:(RCModel *)rcmodel{
    [self.godimg sd_setImageWithURL:[NSURL URLWithString:rcmodel.cover] placeholderImage:nil];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
