//
//  type1TableViewCell.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "type1TableViewCell.h"
#import "RCModel.h"
@implementation type1TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRcmodel:(RCModel *)rcmodel{
    _rcmodel = rcmodel;
    [self.godimg sd_setImageWithURL:[NSURL URLWithString:rcmodel.cover] placeholderImage:[UIImage imageNamed:@"placehold.jpg"]];
    self.godtitle.text = rcmodel.title;
    self.godsummary.text = rcmodel.summary;
    self.godsummary.numberOfLines = 0;
    NSString *like = [NSString stringWithFormat:@"%@",rcmodel.like];
    self.godlike.text = like;
  
    
    if (rcmodel.tag.count ==0) {
        self.godtag.text = nil;
        return;
    }else{
        self.godtag.text = rcmodel.tag[0];
    }
}


//cell上控件绑定内容
-(void)bandingstatus:(RCModel *)rcmodel{
    [self.godimg sd_setImageWithURL:[NSURL URLWithString:rcmodel.cover] placeholderImage:nil];
    self.godtitle.text = rcmodel.title;
    self.godsummary.text = rcmodel.summary;
    self.godlike.text = rcmodel.like;
    self.godtag.text = rcmodel.tag[0];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
