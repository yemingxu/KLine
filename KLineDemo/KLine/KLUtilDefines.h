//
//  KLUtilDefines.h
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#ifndef KLUtilDefines_h
#define KLUtilDefines_h

/*  颜色   */
#define YMUIColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define YMUIColorRGBAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define YMUIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kYMColorWhite [UIColor whiteColor]
#define kYMColorBlack [UIColor blackColor]

/// 灰色，例如：提示
#define kColorGrayText YMUIColorHex(0x8C8D8E)
/// 红色
#define KRedColor YMUIColorHex(0xff007b)

#define kWeakBlackColor  YMUIColorHex(0x5786d2)
#define kGoUpColor  YMUIColorHex(0xe76d42)
#define kGoDownColor  YMUIColorHex(0x07c087)


/*    */

#define KLMAX(A,B,C,D) (MAX(MAX(A,B),MAX(C,D)))
#define KLMIN(A,B,C,D) (MIN(MIN(A,B),MIN(C,D)))



#endif /* KLUtilDefines_h */
