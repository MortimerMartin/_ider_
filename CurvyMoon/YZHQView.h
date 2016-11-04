//
//  YZHQView.h
//  CurvyMoon
//
//  Created by qingyun on 16/5/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZHQView : UIView

@property (nonatomic,retain) UIView *innerView;
@property (nonatomic,retain) UIViewController *parentVC;
@property (nonatomic,retain) UIView *view;

+(instancetype) defaultPopuView;

@end
