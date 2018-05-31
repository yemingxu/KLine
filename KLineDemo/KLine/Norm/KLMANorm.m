//
//  KLMANorm.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLMANorm.h"

@interface KLMANorm()
{
    LineChartDataSet *_MA5LineSet;
    LineChartDataSet *_MA10LineSet;
    LineChartDataSet *_MA30LineSet;
    LineChartDataSet *_MA60LineSet;
}
@end
@implementation KLMANorm
- (void)resetSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    
    [self clearSets];
    _MA5LineSet = nil;
    _MA10LineSet = nil;
    _MA30LineSet = nil;
    _MA60LineSet = nil;
    
    if ([calcResult MA5].count){
        
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.MA5];
        _MA5LineSet = set;
        [self addLineSet:set];
    }
    if ([calcResult MA10].count){
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.MA10];
        _MA10LineSet = set;
        [self addLineSet:set];
    }
    if ([calcResult MA30].count){
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.MA30];
        _MA30LineSet = set;
        [self addLineSet:set];
    }
    if ([calcResult MA60].count){
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.MA60];
        _MA60LineSet = set;
        [self addLineSet:set];
    }
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-result"

- (void)addDataEntryToSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    if ([calcResult MA5].count && _MA5LineSet){
        
        [_MA5LineSet addEntry:calcResult.MA5.lastObject];
        
    }
    if ([calcResult MA10].count && _MA10LineSet){
        
        [_MA10LineSet addEntry:calcResult.MA10.lastObject];

    }
    if ([calcResult MA30].count && _MA30LineSet){
        
        [_MA30LineSet addEntry:calcResult.MA30.lastObject];

    }
    if ([calcResult MA60].count && _MA60LineSet){
        
        [_MA60LineSet addEntry:calcResult.MA60.lastObject];
    }

}

#pragma clang diagnostic pop
@end
