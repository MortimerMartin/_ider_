//
//  qiushenwenbu.h
//  CurvyMoon
//
//  Created by qingyun on 16/5/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol qiushenwenbuDelegate <NSObject>

- (void)menuButtonClicked:(int)index;

@end

@interface qiushenwenbu : NSObject
{
    NSMutableArray      *_buttonList;
    UIView *backView;
}
@property (nonatomic, strong) UIView *backgroundMenuView;

@property (nonatomic, strong) UIButton *menuButton;

@property (nonatomic, retain) UIColor *menuColor;
@property (nonatomic) BOOL isOpen;

@property (nonatomic, retain) id<qiushenwenbuDelegate> delegate;

- (qiushenwenbu *)initWithImages:(NSArray*)buttonList;


- (void)insertMenuViewOnView;
@end
