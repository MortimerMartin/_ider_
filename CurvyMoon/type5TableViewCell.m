//
//  type5TableViewCell.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "type5TableViewCell.h"
#import "RCModel.h"
@implementation type5TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRcmodel:(RCModel *)rcmodel{
    _rcmodel = rcmodel;
    self.godtitle.text = rcmodel.title;
    self.godnumber.text = [NSString stringWithFormat:@"%ld张美图",(unsigned long)rcmodel.album.count];
    self.goddate.text = [self goddateWithDate:rcmodel.date];
    [self.leftimg sd_setImageWithURL:[NSURL URLWithString:rcmodel.album[0][@"url"]] placeholderImage:nil];
    [self.middleimg sd_setImageWithURL:[NSURL URLWithString:rcmodel.album[1][@"url"]] placeholderImage:nil];
    [self.rightimg sd_setImageWithURL:[NSURL URLWithString:rcmodel.album[2][@"url"]] placeholderImage:nil];

}

- (NSString *)goddateWithDate:(NSString *)dater{
    NSString *time = [NSString stringWithFormat:@"%@",dater];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSDate *date =[NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[time intValue]];
    NSString *timer = [formatter stringFromDate:date];
    return timer;
}


//cell上控件绑定内容
-(void)bandingstatus:(RCModel *)rcmodel{


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
