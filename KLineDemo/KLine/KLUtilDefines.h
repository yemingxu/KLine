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
#define KLUIColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define KLUIColorRGBAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define KLUIColorHexAlpha(hex,Aplha) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:Aplha]
#define KLUIColorHex(hex) KLUIColorHexAlpha(hex,1.0)

#define KLColorWhite [UIColor whiteColor]
#define KLColorBlack [UIColor blackColor]

/// 灰色，例如：提示
#define KLGrayTextColor KLUIColorHex(0x8C8D8E)

#define KLWeakBlackColor  KLUIColorHex(0x5786d2)
#define KLGoUpColor  KLUIColorHex(0xe76d42)
#define KLGoDownColor  KLUIColorHex(0x07c087)

#define KLWWeakBlackColor  KLUIColorHexAlpha(0x5786d2,0.3)

/*    */

#define KLMAX(A,B,C,D) (MAX(MAX(A,B),MAX(C,D)))
#define KLMIN(A,B,C,D) (MIN(MIN(A,B),MIN(C,D)))




/*  */


#import <CoreGraphics/CoreGraphics.h>
#define KLLineWidthValue ((CGFloat)1.0)
#define KLBarSpaceValue ((CGFloat)0.3)
#define KLBarVisibleMaxWidthPixel ((CGFloat)15.0)


#endif /* KLUtilDefines_h */
