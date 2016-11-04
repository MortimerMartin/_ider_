//
//  substitute.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "substitute.h"

@implementation substitute
+(NSArray *)RCModelWithArray:(NSArray *)infos{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:infos.count];
    [infos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        substitute *DT = [[substitute alloc] initWithRCDic:obj];
        [result addObject:DT];
    }];
    
    return result;
}

-(instancetype)initWithRCDic:(NSDictionary *)info{
    
    if (self = [super init]) {
        self.uid = info[@"uid"];
        self.title = info[@"title"];
        self.summary = info[@"summary"];
        self.cover = info[@"cover"];
        self.album = info[@"album"];   //无奈之举；
        self.like = info[@"like"];
//        self.tag = info[@"tag"];
        self.type = info[@"type"];
        self.date = info[@"date"];
        self.tid = info[@"tid"];
    }
    return self;
}//字典转回为模型对象
@end
