//
//  KLFixedNorm.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLFixedNorm.h"

@interface KLFixedNorm()
{
    LineChartDataSet *_fixedLineSet;
    CandleChartDataSet *_fixedCandleSet;
}
@end

@implementation KLFixedNorm

- (void)resetSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    
    [self clearSets];

    BOOL candleFlag = [[calcResult candle] count];
    BOOL timeshareFlag = [[calcResult timeshare] count];
    _fixedLineSet = nil;
    _fixedCandleSet = nil;
    if (candleFlag){
        
        CandleChartDataSet *set = [self.class generateBasalCandleChartDataSet];
        [set setValues:calcResult.candle];
        _fixedCandleSet = set;
        [self addCandleSet:set];
    }else if (timeshareFlag){
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.timeshare];
        _fixedLineSet = set;
        [self addLineSet:set];

    }
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-result"

- (void)addDataEntryToSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    BOOL candleFlag = [[calcResult candle] count];
    BOOL timeshareFlag = [[calcResult timeshare] count];
    if (_fixedLineSet && timeshareFlag){
        [_fixedLineSet addEntry:calcResult.timeshare.lastObject];
    }else if(_fixedCandleSet && candleFlag){
        [_fixedCandleSet addEntry:calcResult.candle.lastObject];
    }
}

#pragma clang diagnostic pop
@end
