//
//  UISpec.h
//  iStockNew
//
//  Created by Delpan on 15/7/27.
//  Copyright (c) 2015年 Delpan. All rights reserved.
//

#import "UISpecHelper.h"

#define HEXCOLOR(c) [UIColor colorWithRed:((c >> 16) & 0xFF) / 255.0 green:((c >> 8) & 0xFF) / 255.0 blue:((c) & 0xFF) / 255.0 alpha:1.0]

/** 屏幕宽度比例 */
#define iPhoneWidthScale   [UISpecHelper widthScale]
/** 屏幕高度比例 */
#define iPhoneHeightScale   [UISpecHelper heightScale]

// 字体
/** 最大字体 : 30.0 */
#define FontMax   [UISpecHelper fontMax]
/** 最大粗字体 : 30.0 */
#define FontMaxBold   [UISpecHelper fontMaxBold]
/** 一号字体 : 18.0 */
#define FontFirst   [UISpecHelper fontFirst]
/** 一号粗字体 : 18.0 */
#define FontFirstBold   [UISpecHelper fontFirstBold]
/** 二号字体 : 16.0 */
#define FontSecond   [UISpecHelper fontSecond]
/** 二号粗字体 : 16.0 */
#define FontSecondBold   [UISpecHelper fontSecondBold]
/** 三号字体 : 13.0 */
#define FontThird   [UISpecHelper fontThird]
/** 三号粗字体 : 13.0 */
#define FontThirdBold   [UISpecHelper fontThirdBold]
/** 四号字体 : 11.0 */
#define FontFourth   [UISpecHelper fontFourth]
/** 四号粗字体 : 11.0 */
#define FontFourthBold   [UISpecHelper fontFourthBold]

// 文本颜色
/** 文本 : 黑色 */
#define TextBlack   [UISpecHelper textBlack]
/** 文本 : 白色 */
#define TextWhite   [UISpecHelper textWhite]
/** 文本 : 灰色 */
#define TextGray   [UISpecHelper textGray]
/** 文本 : 红色 */
#define TextRed   [UISpecHelper textRed]
/** 文本 : 绿色 */
#define TextGreen   [UISpecHelper textGreen]
/** 文本 : 蓝色 */
#define TextBlue   [UISpecHelper textBlue]

// 背景色
/** 背景 : 白色 */
#define BackWhite   [UISpecHelper backWhite]
/** 背景 : 浅灰色 */
#define BackLightGray   [UISpecHelper backLightGray]
/** 背景 : 蓝色 */
#define BackBlue   [UISpecHelper backBlue]
/** 背景 : 红色 */
#define BackRed   [UISpecHelper backRed]
/** 背景 : 绿色 */
#define BackGreen   [UISpecHelper backGreen]
/** 背景 : 裸红 */
#define BackPink   [UISpecHelper backPink]
/** 背景 : 青色 */
#define BackCyan   [UISpecHelper backCyan]
/** 背景 :  浅绿色 */
#define BackLightGreen [UISpecHelper backLightGreen]

// 线颜色
/** 分割线 : 灰色 */
#define LineGray   [UISpecHelper lineGray]

/** 分割线 : 绿色 */
#define LineGreen   [UISpecHelper lineGreen]

 


































