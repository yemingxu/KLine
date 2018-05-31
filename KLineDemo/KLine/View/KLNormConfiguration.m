//
//  KLNormConfiguration.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/29.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLNormConfiguration.h"
#import "KLMANorm.h"
#import "KLVolNorm.h"
#import "KLMACDNorm.h"
#import "KLBOLLNorm.h"
#import "KLKDJNorm.h"
#import "KLRSINorm.h"

NSString *KLNormVisibleMainRawValue(KLNormVisibleMain visible)
{
    switch (visible) {
        case KLNormVisibleMain_None:
            return @"KLNormVisibleMain_None";
        case KLNormVisibleMain_MA:
            return @"KLNormVisibleMain_MA";
        case KLNormVisibleMain_BOLL:
            return @"KLNormVisibleMain_BOLL";
    }
}

NSString *KLNormVisibleHelpRawValue(KLNormVisibleHelp visible)
{
    switch (visible) {
        case KLNormVisibleHelp_None:
            return @"KLNormVisibleHelp_None";
        case KLNormVisibleHelp_Vol:
            return @"KLNormVisibleHelp_Vol";
        case KLNormVisibleHelp_MACD:
            return @"KLNormVisibleHelp_MACD";
        case KLNormVisibleHelp_KDJ:
            return @"KLNormVisibleHelp_KDJ";
        case KLNormVisibleHelp_RSI:
            return @"KLNormVisibleHelp_RSI";
    }
}


@implementation KLNormConfiguration

+ (NSArray<id> *)defaultMainNorms
{
    
    return @[[KLMANorm normWithName:KLNormVisibleMainRawValue(KLNormVisibleMain_MA)],
             [KLBOLLNorm normWithName:KLNormVisibleMainRawValue(KLNormVisibleMain_BOLL)]];
    
}

+ (NSArray<id> *)defaultHelpNorms
{
    
    return @[[KLVolNorm normWithName:KLNormVisibleHelpRawValue(KLNormVisibleHelp_Vol)],
             [KLMACDNorm normWithName:KLNormVisibleHelpRawValue(KLNormVisibleHelp_MACD)],
             [KLKDJNorm normWithName:KLNormVisibleHelpRawValue(KLNormVisibleHelp_KDJ)],
             [KLRSINorm normWithName:KLNormVisibleHelpRawValue(KLNormVisibleHelp_RSI)]];

}



@end
