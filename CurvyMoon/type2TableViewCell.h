//
//  type2TableViewCell.h
//  CurvyMoon
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCModel;
@interface type2TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *godimg;
@property (nonatomic , strong) RCModel *rcmodel;

//cell上控件绑定内容
-(void)bandingstatus:(RCModel *)rcmodel;

@end
