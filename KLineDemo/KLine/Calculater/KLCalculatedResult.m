//
//  KLCalculatedResult.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLCalculatedResult.h"

@implementation KLCalculatedResult

@end


@implementation KLCalculater (Result)

+ (KLCalculatedResult *)calculateEntries:(KLEntries *)entries
{
    
    KLCandleChartDataMutableEntries *out_candle;
    KLChartDataMutableEntries *out_timeshare;
    KLBarChartDataEntries *out_vol;
    KLChartDataEntries *out_MA5;
    KLChartDataEntries *out_MA10;
    KLChartDataEntries *out_MA30;
    KLChartDataEntries *out_MA60;
    KLChartDataEntries *out_EMA12;
    KLChartDataEntries *out_EMA26;
    KLChartDataEntries *out_MACD_DIF;
    KLChartDataEntries *out_MACD_DEA;
    KLBarChartDataEntries *out_MACD_BAR;
    KLChartDataEntries *out_BOLL_MB;
    KLChartDataEntries *out_BOLL_UP;
    KLChartDataEntries *out_BOLL_DN;
    
    KLChartDataEntries *out_KDJ_K;
    KLChartDataEntries *out_KDJ_D;
    KLChartDataEntries *out_KDJ_J;

    KLChartDataEntries *RSI6;
    KLChartDataEntries *RSI12;
    KLChartDataEntries *RSI24;
    
    if (![self calcEntries:entries outputCandle:&out_candle timeshare:&out_timeshare vol:&out_vol MA5:&out_MA5 MA10:&out_MA10 MA30:&out_MA30 MA60:&out_MA60 EMA12:&out_EMA12 EMA26:&out_EMA26 MACD_DIF:&out_MACD_DIF MACD_DEA:&out_MACD_DEA MACD_BAR:&out_MACD_BAR BOLL_MB:&out_BOLL_MB BOLL_UP:&out_BOLL_UP BOLL_DN:&out_BOLL_DN KDJ_K:&out_KDJ_K KDJ_D:&out_KDJ_D KDJ_J:&out_KDJ_J RSI6:&RSI6 RSI12:&RSI12 RSI24:&RSI24]){
        return nil;
    }
    
    KLCalculatedResult *result = [[KLCalculatedResult alloc] init];
    result.entries = entries;
    result.candle = out_candle;
    result.timeshare = out_timeshare;
    result.vol = out_vol;
    
    result.MA5 = out_MA5;
    result.MA10 = out_MA10;
    result.MA30 = out_MA30;
    result.MA60 = out_MA60;
    
    result.EMA12 = out_EMA12;
    result.EMA26 = out_EMA26;
    result.MACD_DIF = out_MACD_DIF;
    result.MACD_DEA = out_MACD_DEA;
    result.MACD_BAR = out_MACD_BAR;

    
    result.BOLL_MB = out_BOLL_MB;
    result.BOLL_UP = out_BOLL_UP;
    result.BOLL_DN = out_BOLL_DN;
    
    result.KDJ_K = out_KDJ_K;
    result.KDJ_D = out_KDJ_D;
    result.KDJ_J = out_KDJ_J;
    
    result.RSI6 = RSI6;
    result.RSI12 = RSI12;
    result.RSI24 = RSI24;

    
    return result;
}

+ (void)calculateForAddEntriy:(KLEntry *)e toLastResult:(KLCalculatedResult *)result
{
    if (!result || !result.entries.count || !e || ![e isUsable]) return;
    
    KLMutableEntries *tmpEntries = [NSMutableArray arrayWithArray:result.entries];
    [tmpEntries addObject:e];
    KLEntries *nowEntries = [NSArray arrayWithArray:tmpEntries];
    
    KLCandleChartDataEntries *out_candle;
    KLChartDataEntries *out_timeshare;
    KLBarChartDataEntries *out_vol;
    KLChartDataEntries *out_MA5;
    KLChartDataEntries *out_MA10;
    KLChartDataEntries *out_MA30;
    KLChartDataEntries *out_MA60;
    KLChartDataEntries *out_EMA12;
    KLChartDataEntries *out_EMA26;
    KLChartDataEntries *out_MACD_DIF;
    KLChartDataEntries *out_MACD_DEA;
    KLBarChartDataEntries *out_MACD_BAR;
    KLChartDataEntries *out_BOLL_MB;
    KLChartDataEntries *out_BOLL_UP;
    KLChartDataEntries *out_BOLL_DN;
    
    KLChartDataEntries *out_KDJ_K;
    KLChartDataEntries *out_KDJ_D;
    KLChartDataEntries *out_KDJ_J;
    
    KLChartDataEntries *RSI6;
    KLChartDataEntries *RSI12;
    KLChartDataEntries *RSI24;
    
    if (![self calcEntries:nowEntries outputCandle:&out_candle timeshare:&out_timeshare vol:&out_vol MA5:&out_MA5 MA10:&out_MA10 MA30:&out_MA30 MA60:&out_MA60 EMA12:&out_EMA12 EMA26:&out_EMA26 MACD_DIF:&out_MACD_DIF MACD_DEA:&out_MACD_DEA MACD_BAR:&out_MACD_BAR BOLL_MB:&out_BOLL_MB BOLL_UP:&out_BOLL_UP BOLL_DN:&out_BOLL_DN KDJ_K:&out_KDJ_K KDJ_D:&out_KDJ_D KDJ_J:&out_KDJ_J RSI6:&RSI6 RSI12:&RSI12 RSI24:&RSI24]){
        return;
    }
    
    result.entries = nowEntries;
    
    result.candle = out_candle;
    result.timeshare = out_timeshare;
    result.vol = out_vol;
    
    result.MA5 = out_MA5;
    result.MA10 = out_MA10;
    result.MA30 = out_MA30;
    result.MA60 = out_MA60;
    
    result.EMA12 = out_EMA12;
    result.EMA26 = out_EMA26;
    result.MACD_DIF = out_MACD_DIF;
    result.MACD_DEA = out_MACD_DEA;
    result.MACD_BAR = out_MACD_BAR;
    
    result.BOLL_MB = out_BOLL_MB;
    result.BOLL_UP = out_BOLL_UP;
    result.BOLL_DN = out_BOLL_DN;
    
    result.KDJ_K = out_KDJ_K;
    result.KDJ_D = out_KDJ_D;
    result.KDJ_J = out_KDJ_J;
    
    result.RSI6 = RSI6;
    result.RSI12 = RSI12;
    result.RSI24 = RSI24;

}



@end
