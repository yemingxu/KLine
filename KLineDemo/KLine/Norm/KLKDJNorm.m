//
//  KLKDJNorm.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/31.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLKDJNorm.h"

@interface KLKDJNorm()
{
    
    LineChartDataSet *_ph_lineSet;
    
    
    LineChartDataSet *_K_LineSet;
    LineChartDataSet *_D_LineSet;
    LineChartDataSet *_J_LineSet;
}
@end
@implementation KLKDJNorm
- (void)resetSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    
    [self clearSets];
    _K_LineSet = nil;
    _D_LineSet = nil;
    _J_LineSet = nil;
    
    
    CGFloat _ph_y = calcResult.KDJ_K.firstObject.y ?: 0.0;
    _ph_lineSet = [self.class spaceChartDataSet:_ph_y];
    [self addLineSet:_ph_lineSet];
    
    
    if ([calcResult KDJ_K].count){
        
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.KDJ_K];
        _K_LineSet = set;
        [self addLineSet:set];
    }
    
    if ([calcResult KDJ_D].count){
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.KDJ_D];
        _D_LineSet = set;
        [self addLineSet:set];
    }
    
    if ([calcResult KDJ_J].count){
        LineChartDataSet *set = [self.class generateBasalLineChartDataSet];
        [set setValues:calcResult.KDJ_J];
        _J_LineSet = set;
        [self addLineSet:set];
    }
    
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-result"

- (void)addDataEntryToSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    if ([calcResult KDJ_K].count && _K_LineSet){
        
        [_K_LineSet addEntry:calcResult.KDJ_K.lastObject];
    }
    if ([calcResult KDJ_D].count && _D_LineSet){
        
        [_D_LineSet addEntry:calcResult.KDJ_D.lastObject];
        
    }
    if ([calcResult KDJ_J].count && _J_LineSet){
        
        [_J_LineSet addEntry:calcResult.KDJ_J.lastObject];
    }
}

#pragma clang diagnostic pop
@end
