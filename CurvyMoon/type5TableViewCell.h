//
//  type5TableViewCell.h
//  CurvyMoon
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCModel;
@interface type5TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *godtitle;
@property (weak, nonatomic) IBOutlet UILabel *godnumber;
@property (weak, nonatomic) IBOutlet UILabel *goddate;
@property (weak, nonatomic) IBOutlet UIImageView *leftimg;
@property (weak, nonatomic) IBOutlet UIImageView *middleimg;
@property (weak, nonatomic) IBOutlet UIImageView *rightimg;

@property (nonatomic , strong) RCModel *rcmodel;

//cell上控件绑定内容
-(void)bandingstatus:(RCModel *)rcmodel;
@end
