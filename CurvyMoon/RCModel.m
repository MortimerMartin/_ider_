//
//  RCModel.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "RCModel.h"

@implementation RCModel

+(NSArray *)RCModelWithArray:(NSArray *)infos{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:infos.count];
    [infos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RCModel *RC = [[RCModel alloc] initWithRCDic:obj];
        [result addObject:RC];
    }];
    
    return result;
}

-(instancetype)initWithRCDic:(NSDictionary *)info{
    
    if (self = [super init]) {
        self.uid = info[@"uid"];
        self.title = info[@"title"];
        self.summary = info[@"summary"];
        self.cover = info[@"cover"];
        self.album = info[@"album"];
        self.like = info[@"like"];
        self.tag = info[@"tag"];
        self.type = info[@"type"];
        self.date = info[@"date"];
        self.tid = info[@"tid"];
    }
    return self;
}//字典转回为模型对象


@end
