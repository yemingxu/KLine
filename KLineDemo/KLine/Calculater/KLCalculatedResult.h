//
//  KLCalculatedResult.h
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLCalculater.h"

@interface KLCalculatedResult : NSObject

@property (nonatomic,strong) KLEntries *entries;

@property (nonatomic,strong) KLCandleChartDataEntries *candle;
@property (nonatomic,strong) KLChartDataEntries *timeshare;
@property (nonatomic,strong) KLBarChartDataEntries *vol;
@property (nonatomic,strong) KLChartDataEntries *MA5;// 备注: SMA就是MA - 简单移动平均
@property (nonatomic,strong) KLChartDataEntries *MA10;
@property (nonatomic,strong) KLChartDataEntries *MA30;
@property (nonatomic,strong) KLChartDataEntries *MA60;
@property (nonatomic,strong) KLChartDataEntries *EMA12;
@property (nonatomic,strong) KLChartDataEntries *EMA26;
@property (nonatomic,strong) KLChartDataEntries *MACD_DIF;
@property (nonatomic,strong) KLChartDataEntries *MACD_DEA;
@property (nonatomic,strong) KLBarChartDataEntries *MACD_BAR;
@property (nonatomic,strong) KLChartDataEntries *BOLL_MB;
@property (nonatomic,strong) KLChartDataEntries *BOLL_UP;
@property (nonatomic,strong) KLChartDataEntries *BOLL_DN;


@property (nonatomic,strong) KLChartDataEntries *KDJ_K;
@property (nonatomic,strong) KLChartDataEntries *KDJ_D;
@property (nonatomic,strong) KLChartDataEntries *KDJ_J;

@property (nonatomic,strong) KLChartDataEntries *RSI6;
@property (nonatomic,strong) KLChartDataEntries *RSI12;
@property (nonatomic,strong) KLChartDataEntries *RSI24;

@end


@interface KLCalculater (Result)

+ (KLCalculatedResult *)calculateEntries:(KLEntries *)entries;

+ (void)calculateForAddEntriy:(KLEntry *)e toLastResult:(KLCalculatedResult *)result;


@end
