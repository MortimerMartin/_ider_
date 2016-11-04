//
//  RCModel.h
//  CurvyMoon
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCModel : NSObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *uname;
@property (nonatomic, strong) NSString *avater;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *summary; // 二级标题
@property (nonatomic, strong) NSString *title; //大标题
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *cover; //图片
@property (nonatomic, strong) NSArray *album;


@property (nonatomic, strong) NSString *views;
@property (nonatomic, strong) NSString *forward;
@property (nonatomic, strong) NSString *reply;
@property (nonatomic, strong) NSString *like; //评论
//@property (nonatomic, assign) NSInteger like; //评论
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *is_special;
@property (nonatomic, strong) NSArray *tag;  //来源
@property (nonatomic, strong) NSString *index_recommend;

@property (nonatomic, strong) NSString *column_recommend;

@property (nonatomic, strong) NSString *show_title;
@property (nonatomic, strong) NSString *type; //判断cellstyle
//@property (nonatomic, assign) NSInteger type; //判断cellstyle



//@property (nonatomic , strong) NSArray *godArray;
-(instancetype)initWithRCDic:(NSDictionary *)info;//字典转回为模型对象

+(NSArray *)RCModelWithArray:(NSArray *)infos;

@end
