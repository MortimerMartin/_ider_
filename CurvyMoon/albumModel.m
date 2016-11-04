//
//  albumModel.m
//  CurvyMoon
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "albumModel.h"

@implementation albumModel

+ (NSArray *)albumWithArray:(NSArray *)infos{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:infos.count];
    [infos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        albumModel *album = [[albumModel alloc] initWithAlbum:obj];
        [result addObject:album];
    }];
    
    return result;
}

//+ (instancetype)albumWithDictionary:(NSDictionary *)dicts{
//    
//    return [[self alloc] albumWithArray:];
//}

- (instancetype)initWithAlbum:(NSDictionary *)info{
    if (self = [super init]) {
        self.thumb = info[@"thumb"];
        self.path = info[@"path"];
        self.width = info[@"width"];
        self.height = info[@"height"];
        self.ext = info[@"ext"];
        self.alt = info[@"alt"];
        self.alt = info[@"alt"];
        self.desc = info[@"desc"];
    }
    return self;
}
@end
