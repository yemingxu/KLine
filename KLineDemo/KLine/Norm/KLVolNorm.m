//
//  KLVolNorm.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLVolNorm.h"

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
        
    }
}

#pragma clang diagnostic pop
@end
