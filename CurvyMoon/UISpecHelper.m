//
//  UISpecHelper.m
//  iStockNew
//
//  Created by Delpan on 15/7/14.
//  Copyright (c) 2015年 Delpan. All rights reserved.
//

#define HEXCOLOR(c) [UIColor colorWithRed:((c >> 16) & 0xFF) / 255.0 green:((c >> 8) & 0xFF) / 255.0 blue:((c) & 0xFF) / 255.0 alpha:1.0]

#import "UISpecHelper.h"

@interface UISpecHelper ()

/** 屏幕宽度比例 */
@property (nonatomic, assign) CGFloat widthScale;
/** 屏幕高度比例 */
@property (nonatomic, assign) CGFloat heightScale;

/** 最大字体 */
@property (nonatomic, assign) CGFloat maxSize;
/** 一号字体大小 : 18.0 */
@property (nonatomic, assign) CGFloat firstSize;
/** 二号字体大小 : 16.0 */
@property (nonatomic, assign) CGFloat secondSize;
/** 三号字体大小 : 13.0 */
@property (nonatomic, assign) CGFloat thirdSize;
/** 四号字体大小 : 11.0 */
@property (nonatomic, assign) CGFloat fourthSize;

// 字体字典
@property (nonatomic, strong) NSMutableDictionary *fontsDic;
// 颜色字典
@property (nonatomic, strong) NSMutableDictionary *colorsDic;

@end

@implementation UISpecHelper

+ (instancetype)instance
{
    static UISpecHelper *object = nil;
    
    static dispatch_once_t onceToKen;
    
    dispatch_once(&onceToKen, ^{
        
        BOOL iphonePlus = (iPhoneWidth == 414.0f);
        
        object = [UISpecHelper new];
        object.widthScale = (iPhoneWidth / 320.0f);
        object.heightScale = (iPhoneHeight / 568.0f);
        object.maxSize = (iphonePlus ? 34.0f : 30.0f);
        object.firstSize = (iphonePlus ? 19.0f : 17.0f);
        object.secondSize = (iphonePlus ? 17.0f : 15.0f);
        object.thirdSize = (iphonePlus ? 15.0f : 13.0f);
        object.fourthSize = (iphonePlus ? 12.0f : 11.0f);
    });
    
    return object;
}

#pragma mark - 当前比例 -
#pragma mark 宽度比例
+ (CGFloat)widthScale
{
    return [[UISpecHelper instance] widthScale];
}

#pragma mark 高度比例
+ (CGFloat)heightScale
{
    return [[UISpecHelper instance] heightScale];
}

#pragma mark - 字体 -
#pragma mark 生成字体
+ (UIFont *)checkFontWithName:(NSString *)name size:(CGFloat)size bold:(BOOL)bold
{
    UISpecHelper *object = [UISpecHelper instance];
    object.fontsDic ?: [object setFontsDic:[NSMutableDictionary dictionary]];
    
    if (![object.fontsDic objectForKey:name])
    {
        UIFont *font = (bold ? [UIFont boldSystemFontOfSize:size] : [UIFont systemFontOfSize:size]);
        
        [object.fontsDic setObject:font forKey:name];
    }
    
    return [object.fontsDic objectForKey:name];
}

#pragma mark 最大字体
+ (UIFont *)fontMax
{
    return [UISpecHelper checkFontWithName:@"fontMax" size:[[UISpecHelper instance] maxSize] bold:NO];
}

#pragma mark 最大粗字体
+ (UIFont *)fontMaxBold
{
    return [UISpecHelper checkFontWithName:@"fontMaxBold" size:[[UISpecHelper instance] maxSize] bold:YES];
}

#pragma mark 一号字体
+ (UIFont *)fontFirst
{
    return [UISpecHelper checkFontWithName:@"fontFirst" size:[[UISpecHelper instance] firstSize] bold:NO];
}

#pragma mark 一号粗字体
+ (UIFont *)fontFirstBold
{
    return [UISpecHelper checkFontWithName:@"fontFirstBold" size:[[UISpecHelper instance] firstSize] bold:YES];
}

#pragma mark 二号字体
+ (UIFont *)fontSecond
{
    return [UISpecHelper checkFontWithName:@"fontSecond" size:[[UISpecHelper instance] secondSize] bold:NO];
}

#pragma mark 二号粗字体
+ (UIFont *)fontSecondBold
{
    return [UISpecHelper checkFontWithName:@"fontSecondBold" size:[[UISpecHelper instance] secondSize] bold:YES];
}

#pragma mark 三号字体
+ (UIFont *)fontThird
{
    return [UISpecHelper checkFontWithName:@"fontThird" size:[[UISpecHelper instance] thirdSize] bold:NO];
}

#pragma mark 三号粗字体
+ (UIFont *)fontThirdBold
{
    return [UISpecHelper checkFontWithName:@"fontThirdBold" size:[[UISpecHelper instance] thirdSize] bold:YES];
}

#pragma mark 四号字体
+ (UIFont *)fontFourth
{
    return [UISpecHelper checkFontWithName:@"fontFourth" size:[[UISpecHelper instance] fourthSize] bold:NO];
}

#pragma mark 四号粗字体
+ (UIFont *)fontFourthBold
{
    return [UISpecHelper checkFontWithName:@"fontFourthBold" size:[[UISpecHelper instance] fourthSize] bold:YES];
}

#pragma mark 自定义字体
+ (UIFont *)fontCustom:(CGFloat)size bold:(BOOL)bold
{
    CGFloat currentSize = (size * [[UISpecHelper instance] widthScale]);
    
    return bold ? [UIFont boldSystemFontOfSize:currentSize] : [UIFont systemFontOfSize:currentSize];
}

#pragma mark - 颜色 -
#pragma mark 判断颜色是否存在
+ (UIColor *)checkColorWithName:(NSString *)name color:(NSInteger)color
{
    UISpecHelper *object = [UISpecHelper instance];
    object.colorsDic ?: [object setColorsDic:[NSMutableDictionary dictionary]];
    
    if (![object.colorsDic objectForKey:name])
    {
        [object.colorsDic setObject:HEXCOLOR(color) forKey:name];
    }
    
    return [object.colorsDic objectForKey:name];
}

#pragma mark 文本颜色
#pragma mark 黑色
+ (UIColor *)textBlack
{
    return [UISpecHelper checkColorWithName:@"textBlack" color:0x434749];
}

#pragma mark 白色
+ (UIColor *)textWhite
{
    return [UISpecHelper checkColorWithName:@"textWhite" color:0xffffff];
}

#pragma mark 灰色
+ (UIColor *)textGray
{
    return [UISpecHelper checkColorWithName:@"textGray" color:0xa8a8a8];
}

#pragma mark 红色
+ (UIColor *)textRed
{
    return [UISpecHelper checkColorWithName:@"textRed" color:0xf03940];
}

#pragma mark 绿色
+ (UIColor *)textGreen
{
    return [UISpecHelper checkColorWithName:@"textGreen" color:0x33afb0];
}

#pragma mark 蓝色
+ (UIColor *)textBlue
{
    return [UISpecHelper checkColorWithName:@"textBlue" color:0x40afed];
}

#pragma mark 背景色
#pragma mark 白色
+ (UIColor *)backWhite
{
    return [UISpecHelper checkColorWithName:@"backWhite" color:0xffffff];
}

#pragma mark 浅灰色
+ (UIColor *)backLightGray
{
    return [UISpecHelper checkColorWithName:@"backLightGray" color:0xf5f7f6];
}

#pragma mark 蓝色
+ (UIColor *)backBlue
{
    return [UISpecHelper checkColorWithName:@"backBlue" color:0x40afed];
}

#pragma mark 红色
+ (UIColor *)backRed
{
    return [UISpecHelper checkColorWithName:@"backRed" color:0xf03940];
}

#pragma mark 绿色
+ (UIColor *)backGreen
{
    return [UISpecHelper checkColorWithName:@"backGreen" color:0x33afb0];
}

#pragma mark 裸红
+ (UIColor *)backPink
{
    return [UISpecHelper checkColorWithName:@"backPink" color:0xff7070];
}

#pragma mark 青色
+ (UIColor *)backCyan
{
    return [UISpecHelper checkColorWithName:@"backCyan" color:0x62c8c9];
}
#pragma mark 浅绿色
+ (UIColor *)backLightGreen
{
    return [UISpecHelper checkColorWithName:@"backCyan" color:0xeff4f4];
}
#pragma mark 线颜色
#pragma mark 灰色
+ (UIColor *)lineGray
{
    return [UISpecHelper checkColorWithName:@"lineGray" color:0xebedec];
}
+ (UIColor *)lineGreen
{
    return [UISpecHelper checkColorWithName:@"lineGreen" color:0xc7e2dd];
}

@end


































