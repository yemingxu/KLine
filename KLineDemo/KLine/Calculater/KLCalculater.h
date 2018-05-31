//
//  KLCalculater.h
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLEntry.h"
#import "KLSwiftDefines.h"

typedef NSArray<KLEntry *> KLEntries;
typedef NSArray<ChartDataEntry *> KLChartDataEntries;
typedef NSArray<BarChartDataEntry *> KLBarChartDataEntries;
typedef NSArray<CandleChartDataEntry *> KLCandleChartDataEntries;

typedef NSMutableArray<KLEntry *> KLMutableEntries;
typedef NSMutableArray<ChartDataEntry *> KLChartDataMutableEntries;
typedef NSMutableArray<BarChartDataEntry *> KLBarChartDataMutableEntries;
typedef NSMutableArray<CandleChartDataEntry *> KLCandleChartDataMutableEntries;



@interface KLCalculater : NSObject

+ (BOOL)calcEntries:(KLEntries *)entries
       outputCandle:(KLCandleChartDataEntries **)candle
          timeshare:(KLChartDataEntries **)timeshare
                vol:(KLBarChartDataEntries **)vol
                MA5:(KLChartDataEntries **)MA5
               MA10:(KLChartDataEntries **)MA10
               MA30:(KLChartDataEntries **)MA30
               MA60:(KLChartDataEntries **)MA60
              EMA12:(KLChartDataEntries **)EMA12
              EMA26:(KLChartDataEntries **)EMA26
           MACD_DIF:(KLChartDataEntries **)DIF
           MACD_DEA:(KLChartDataEntries **)DEA
           MACD_BAR:(KLBarChartDataEntries **)MACDBAR
            BOLL_MB:(KLChartDataEntries **)BOLL_MB
            BOLL_UP:(KLChartDataEntries **)BOLL_UP
            BOLL_DN:(KLChartDataEntries **)BOLL_DN
              KDJ_K:(KLChartDataEntries **)KDJ_K
              KDJ_D:(KLChartDataEntries **)KDJ_D
              KDJ_J:(KLChartDataEntries **)KDJ_J
               RSI6:(KLChartDataEntries **)RSI6
              RSI12:(KLChartDataEntries **)RSI12
              RSI24:(KLChartDataEntries **)RSI24;


@end





