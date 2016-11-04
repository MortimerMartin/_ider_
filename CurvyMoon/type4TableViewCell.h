//
//  type4TableViewCell.h
//  CurvyMoon
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCModel;
@interface type4TableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *godtitle;

@property (weak, nonatomic) IBOutlet UIImageView *godimg;
@property (weak, nonatomic) IBOutlet UILabel *godsummary;
@property (weak, nonatomic) IBOutlet UILabel *goddate;
@property (nonatomic , strong) RCModel *rcmodel;

//cell上控件绑定内容
-(void)bandingstatus:(RCModel *)rcmodel;

@end
