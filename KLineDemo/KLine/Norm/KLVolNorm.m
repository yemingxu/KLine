//
//  KLVolNorm.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLVolNorm.h"
#import "KLUtilDefines.h"

@interface KLVolNorm()
{
    BarChartDataSet *_volLineSet;
}
@end
@implementation KLVolNorm
- (void)resetSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    
    [self clearSets];

    if ([calcResult vol].count){
        
        BarChartDataSet *set = [self.class generateBasalBarChartDataSet];
        [set setValues:calcResult.vol];
        
        NSMutableArray *tmp_colors = [NSMutableArray arrayWithCapacity:calcResult.vol.count];
        for (int i = 0;i<calcResult.vol.count;i++) {
            tmp_colors[i] = [self __BAR_Color:calcResult.entries[i]];
        }
        [set setColors:tmp_colors];
        
        _volLineSet = set;
        [self addBarSet:set];
        
    }
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-result"

- (void)addDataEntryToSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    if ([calcResult vol].count && _volLineSet){
        
        [_volLineSet addEntry:calcResult.vol.lastObject];
        [_volLineSet addColor:[self __BAR_Color:calcResult.entries.lastObject]];
    }
}

#pragma clang diagnostic pop


- (UIColor *)__BAR_Color:(KLEntry *)e
{
    return (e.open > e.close) ? KLGoDownColor : KLGoUpColor;
}
@end
