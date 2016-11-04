//
//  ImglistView.h
//  CurvyMoon
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImglistView : UIView

@property (nonatomic , strong) NSArray * imglist;

@property (nonatomic , assign) NSInteger currentindex;

@property (nonatomic , strong) void (^CurrentIndex)(NSInteger);

+ (id)S2ImglistView;
@end
