//
//  GradienProgressView.h
//  CurvyMoon
//
//  Created by pro on 16/10/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
@interface GradienProgressView : UIView
{
    
    CALayer *maskLayer;
}

@property (nonatomic , strong) CAGradientLayer * gradienlayer;


@end
