//
//  type4TableViewCell.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "type4TableViewCell.h"
#import "RCModel.h"
@implementation type4TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRcmodel:(RCModel *)rcmodel{
    
    _rcmodel = rcmodel;
    self.godtitle.text = rcmodel.title;
    [self.godimg sd_setImageWithURL:[NSURL URLWithString:rcmodel.cover] placeholderImage:nil];
    self.godsummary.text = rcmodel.summary;
    
    self.goddate.text =[self goddateWithDate:rcmodel.date];
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
    [self.godimg sd_setImageWithURL:[NSURL URLWithString:rcmodel.cover] placeholderImage:nil];
    self.godtitle.text = rcmodel.title;
    self.godsummary.text = rcmodel.summary;
    
    self.goddate.text = nil;  //待 机;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
