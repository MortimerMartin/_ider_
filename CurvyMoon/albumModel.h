//
//  albumModel.h
//  CurvyMoon
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface albumModel : NSObject

@property (nonatomic , strong) NSString * tid;
@property (nonatomic , strong) NSString * uid;
@property (nonatomic , strong) NSString * uname;
@property (nonatomic , strong) NSString * summary;
@property (nonatomic , strong) NSString * title;
@property (nonatomic , strong) NSString * author;
@property (nonatomic , strong) NSString * source;
@property (nonatomic , strong) NSString * detail;
@property (nonatomic , strong) NSString * cover;
@property (nonatomic , strong) NSString * tag;
@property (nonatomic , strong) NSString * views;
@property (nonatomic , strong) NSString * forward;
@property (nonatomic , strong) NSString * reply;
@property (nonatomic , strong) NSString * like;
@property (nonatomic , strong) NSString * date;
@property (nonatomic , strong) NSString * model;
@property (nonatomic , strong) NSString * allow_comment;

@property (nonatomic , strong) NSArray  * imglist;

//imglist
@property (nonatomic , strong) NSString * thumb;
@property (nonatomic , strong) NSString * path;
@property (nonatomic , strong) NSString * ext;
@property (nonatomic , strong) NSString * width;
@property (nonatomic , strong) NSString * height;
@property (nonatomic , strong) NSString * alt;
@property (nonatomic , strong) NSString * desc;


//album
//@property (nonatomic , strong) NSString *url;
//@property (nonatomic , strong) NSString *width;
//@property (nonatomic , strong) NSString *height;
//@property (nonatomic , strong) NSString *ext;
//@property (nonatomic , strong) NSString *size;
//@property (nonatomic , strong) NSString *alt;
//@property (nonatomic , strong) NSString *brief;

- (instancetype)initWithAlbum:(NSDictionary *)info;


+ (NSArray*)albumWithArray:(NSArray *)infos;

@end
