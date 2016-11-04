//
//  UISpecHelper.h
//  iStockNew
//
//  Created by Delpan on 15/7/14.
//  Copyright (c) 2015年 Delpan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UISpecHelper : NSObject

/** 屏幕宽度比例 */
+ (CGFloat)widthScale;
/** 屏幕高度比例 */
+ (CGFloat)heightScale;

// 字体
/** 最大字体 : 30.0 */
+ (UIFont *)fontMax;
/** 最大粗字体 : 30.0 */
+ (UIFont *)fontMaxBold;
/** 一号字体 : 18.0 */
+ (UIFont *)fontFirst;
/** 一号粗字体 : 18.0 */
+ (UIFont *)fontFirstBold;
/** 二号字体 : 16.0 */
+ (UIFont *)fontSecond;
/** 二号粗字体 : 16.0 */
+ (UIFont *)fontSecondBold;
/** 三号字体 : 13.0 */
+ (UIFont *)fontThird;
/** 三号粗字体 : 13.0 */
+ (UIFont *)fontThirdBold;
/** 四号字体 : 11.0 */
+ (UIFont *)fontFourth;
/** 四号粗字体 : 11.0 */
+ (UIFont *)fontFourthBold;

/** 自定义字体 */
+ (UIFont *)fontCustom:(CGFloat)size bold:(BOOL)bold;

// 文本颜色
/** 文本 : 黑色 */
+ (UIColor *)textBlack;
/** 文本 : 白色 */
+ (UIColor *)textWhite;
/** 文本 : 灰色 */
+ (UIColor *)textGray;
/** 文本 : 红色 */
+ (UIColor *)textRed;
/** 文本 : 绿色 */
+ (UIColor *)textGreen;
/** 文本 : 蓝色 */
+ (UIColor *)textBlue;

// 背景色
/** 背景 : 白色 */
+ (UIColor *)backWhite;
/** 背景 : 浅灰色 */
+ (UIColor *)backLightGray;
/** 背景 : 蓝色 */
+ (UIColor *)backBlue;
/** 背景 : 红色 */
+ (UIColor *)backRed;
/** 背景 : 绿色 */
+ (UIColor *)backGreen;
/** 背景 : 裸红 */
+ (UIColor *)backPink;
/** 背景 : 青色 */
+ (UIColor *)backCyan;
/** 背景 : 浅绿色 */
+ (UIColor *)backLightGreen;

// 线颜色
/** 分割线 : 灰色 */
+ (UIColor *)lineGray;
+ (UIColor *)lineGreen;
@end






















