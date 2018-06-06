//
//  KLMACDNorm.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/30.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLMACDNorm.h"
#import "KLUtilDefines.h"

@interface KLMACDNorm()
{
    
    LineChartDataSet *_ph_lineSet;

    
    LineChartDataSet *_DIFLineSet;
    LineChartDataSet *_DEALineSet;
    BarChartDataSet *_MACDBARLineSet;
}
@end
@implementation KLMACDNorm
- (void)resetSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    
    [self clearSets];
    _DIFLineSet = nil;
    _DEALineSet = nil;
    _MACDBARLineSet = nil;
    

    CGFloat _ph_y = calcResult.MACD_DIF.firstObject.y ?: 0.0;
    _ph_lineSet = [self.class spaceChartDataSet:_ph_y];
    [self addLineSet:_ph_lineSet];

    
    if ([calcResult MACD_DIF].count){

        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.MACD_DIF];
        _DIFLineSet = set;
        [self addLineSet:set];
    }
    if ([calcResult MACD_DEA].count){
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.MACD_DEA];
        _DEALineSet = set;
        [self addLineSet:set];
    }
    if ([calcResult MACD_BAR].count){
        BarChartDataSet *set = [self.class generateBasalBarChartDataSet];
        [set setValues:calcResult.MACD_BAR];
        
        NSMutableArray *tmp_colors = [NSMutableArray arrayWithCapacity:calcResult.MACD_BAR.count];
        for (int i = 0;i<calcResult.MACD_BAR.count;i++) {
            BarChartDataEntry *e = calcResult.MACD_BAR[i];
            tmp_colors[i] = [self __MACDBAR_Color:e];
        }
        [set setColors:tmp_colors];
        
        _MACDBARLineSet = set;
        [self addBarSet:set];
    }
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-result"

- (void)addDataEntryToSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    if ([calcResult MACD_DIF].count && _DIFLineSet){
        
        [_DIFLineSet addEntry:calcResult.MACD_DIF.lastObject];
    }
    if ([calcResult MACD_DEA].count && _DEALineSet){
        
        [_DEALineSet addEntry:calcResult.MACD_DEA.lastObject];
        
    }
    if ([calcResult MACD_BAR].count && _MACDBARLineSet){
        
        [_MACDBARLineSet addEntry:calcResult.MACD_BAR.lastObject];
        [_MACDBARLineSet addColor:[self __MACDBAR_Color:calcResult.MACD_BAR.lastObject]];
    }
}

#pragma clang diagnostic pop


- (UIColor *)__MACDBAR_Color:(BarChartDataEntry *)e
{
    return e.y <= 0.0 ? KLGoDownColor : KLGoUpColor;
}
@end
