//
//  KLRSINorm.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/31.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLRSINorm.h"

@interface KLRSINorm()
{
    
    LineChartDataSet *_ph_lineSet;
    
    
    LineChartDataSet *_6_LineSet;
    LineChartDataSet *_12_LineSet;
    LineChartDataSet *_24_LineSet;
}
@end
@implementation KLRSINorm
- (void)resetSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    
    [self clearSets];
    _6_LineSet = nil;
    _12_LineSet = nil;
    _24_LineSet = nil;
    
    
    CGFloat _ph_y = calcResult.RSI6.firstObject.y ?: 0.0;
    _ph_lineSet = [self.class spaceChartDataSet:_ph_y];
    [self addLineSet:_ph_lineSet];
    
    if ([calcResult RSI6].count){
        
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.RSI6];
        _6_LineSet = set;
        [self addLineSet:set];
    }
    
    if ([calcResult RSI12].count){
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.RSI12];
        _12_LineSet = set;
        [self addLineSet:set];
    }
    
    if ([calcResult RSI24].count){
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.RSI24];
        _24_LineSet = set;
        [self addLineSet:set];
    }
    
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-result"

- (void)addDataEntryToSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    if ([calcResult RSI6].count && _6_LineSet){
        
        [_6_LineSet addEntry:calcResult.RSI6.lastObject];
    }
    if ([calcResult RSI12].count && _12_LineSet){
        
        [_12_LineSet addEntry:calcResult.RSI12.lastObject];
        
    }
    if ([calcResult RSI24].count && _24_LineSet){
        
        [_24_LineSet addEntry:calcResult.RSI24.lastObject];
    }
}

#pragma clang diagnostic pop
@end
