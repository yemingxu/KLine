//
//  KLNormConfiguration.h
//  KLineDemo
//
//  Created by JoeXu on 2018/5/29.
//  Copyright © 2018年 KL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLSwiftDefines.h"
#import "KLNorm.h"

typedef NS_ENUM(NSUInteger,KLNormVisibleMain)
{
    KLNormVisibleMain_None,
    KLNormVisibleMain_MA,
    KLNormVisibleMain_BOLL
};
typedef NS_ENUM(NSUInteger,KLNormVisibleHelp)
{
    KLNormVisibleHelp_None,
    KLNormVisibleHelp_Vol,
    KLNormVisibleHelp_MACD,
    KLNormVisibleHelp_KDJ,
    KLNormVisibleHelp_RSI
};

FOUNDATION_EXTERN_INLINE
NSString *KLNormVisibleHelpRawValue(KLNormVisibleHelp visible);

FOUNDATION_EXTERN_INLINE
NSString *KLNormVisibleMainRawValue(KLNormVisibleMain visible);



@interface KLNormConfiguration : NSObject

+ (NSArray<id<KLNorm>> *)defaultMainNorms;
+ (NSArray<id<KLNorm>> *)defaultHelpNorms;

@end

@interface KLNormConfiguration (Visible)

+ (BOOL)isMain:(id<KLNorm>)norm;

+ (BOOL)isHelp:(id<KLNorm>)norm;


@end
