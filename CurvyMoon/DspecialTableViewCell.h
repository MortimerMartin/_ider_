//
//  DspecialTableViewCell.h
//  CurvyMoon
//
//  Created by qingyun on 16/5/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class substitute;
@interface DspecialTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *godimg;
@property (nonatomic , strong) substitute * sub;

@end
