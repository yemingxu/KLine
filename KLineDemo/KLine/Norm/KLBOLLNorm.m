//
//  KLBOLLNorm.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/30.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLBOLLNorm.h"

@interface KLBOLLNorm()
{
    
    LineChartDataSet *_ph_lineSet;
    
    
    LineChartDataSet *_UPLineSet;
    LineChartDataSet *_DNLineSet;
    LineChartDataSet *_MBLineSet;
}
@end
@implementation KLBOLLNorm
- (void)resetSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    
    [self clearSets];
    _MBLineSet = nil;
    _UPLineSet = nil;
    _DNLineSet = nil;
    
    
    CGFloat _ph_y = calcResult.BOLL_MB.firstObject.y ?: 0.0;
    _ph_lineSet = [self.class spaceChartDataSet:_ph_y];
    [self addLineSet:_ph_lineSet];
    
    
    if ([calcResult BOLL_UP].count){
        
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.BOLL_UP];
        _UPLineSet = set;
        [self addLineSet:set];
    }
    
    if ([calcResult BOLL_MB].count){
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.BOLL_MB];
        _MBLineSet = set;
        [self addLineSet:set];
    }
    
    if ([calcResult BOLL_DN].count){
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.BOLL_DN];
        _DNLineSet = set;
        [self addLineSet:set];
    }

}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-result"

- (void)addDataEntryToSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    if ([calcResult BOLL_MB].count && _MBLineSet){
        
        [_MBLineSet addEntry:calcResult.BOLL_MB.lastObject];
    }
    if ([calcResult BOLL_DN].count && _DNLineSet){
        
        [_DNLineSet addEntry:calcResult.BOLL_DN.lastObject];
        
    }
    if ([calcResult BOLL_UP].count && _UPLineSet){
        
        [_UPLineSet addEntry:calcResult.BOLL_UP.lastObject];
    }
}

#pragma clang diagnostic pop

@end
