//
//  KLChartDataVisible.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/29.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLChartDataVisible.h"
#import "KLUtilDefines.h"

@interface KLChartDataVisible()<KLChartDataHolderDelegate>
@end
@implementation KLChartDataVisible

- (void)dataHolder:(KLChartDataHolder *)dataHolder didRefreshSetsIsResetting:(BOOL)resetting
{
    if (![dataHolder isEqual:self.dataHolder]) return;
    
    if (resetting){
        _mainChartData = nil;
        _helpChartData = nil;
        
        [self __refreshVisibleNormIsMain:YES];
        [self __refreshVisibleNormIsMain:NO];
        
        if ([self.delegate respondsToSelector:@selector(dataVisibleRefreshedForReset:)]){
            [self.delegate dataVisibleRefreshedForReset:self];
        }
  
    }else{
        
        if ([self.delegate respondsToSelector:@selector(dataVisibleRefreshedForAddEntry:)]){
            [self.delegate dataVisibleRefreshedForAddEntry:self];
        }

        
    }
    
    
    
}

- (void)prepareWithDataHolder:(KLChartDataHolder *)dataHolder
{
    if (_dataHolder && [_dataHolder.delagete isEqual:self]) {
        _dataHolder.delagete = nil;
    }
    _dataHolder = dataHolder;
    dataHolder.delagete = self;
    [self __refreshVisibleNormIsMain:YES];
}


- (void)setMainVisible:(KLNormVisibleMain)mainVisible
{
    if (_mainVisible == mainVisible) return;
    _mainVisible = mainVisible;

    CombinedChartData *lhs_maindata = _mainChartData;
    [self __refreshVisibleNormIsMain:YES];
    
    if ([self.delegate respondsToSelector:@selector(dataVisibleRefreshedOfMainForNormChanged:dataIsReset:)]){
        BOOL dataIsReset = ![self isEqualChartDataLhs:lhs_maindata rhs:_mainChartData];
        [self.delegate dataVisibleRefreshedOfMainForNormChanged:self dataIsReset:dataIsReset];
    }
    
}
- (void)setHelpVisible:(KLNormVisibleHelp)helpVisible
{
    if (_helpVisible == helpVisible) return;
    _helpVisible = helpVisible;
    
    CombinedChartData *lhs_helpdata = _helpChartData;
    [self __refreshVisibleNormIsMain:NO];
    
    if ([self.delegate respondsToSelector:@selector(dataVisibleRefreshedOfMainForNormChanged:dataIsReset:)]){
        BOOL dataIsReset = ![self isEqualChartDataLhs:lhs_helpdata rhs:_helpChartData];
        [self.delegate dataVisibleRefreshedOfHelpForNormChanged:self dataIsReset:dataIsReset];
    }
}

- (void)__refreshVisibleNormIsMain:(BOOL)isMain
{
    if (!_dataHolder.fixedNorm) return;
    

    
    NSArray *disposeNorms;
    if (isMain){
        id<KLNorm> visibleNorm = [self __findVisibleMainNorm];
        disposeNorms = visibleNorm ? @[_dataHolder.fixedNorm,visibleNorm] : @[_dataHolder.fixedNorm];
    }else{
        id<KLNorm> visibleNorm = [self __findVisibleHelpNorm];
        disposeNorms = visibleNorm ? @[visibleNorm] : nil;
    }

    NSMutableArray<LineChartDataSet *> *lineSets;
    NSMutableArray<BarChartDataSet *> *barSets;
    NSMutableArray<CandleChartDataSet *> *candleSets;
    [self __disposeNorms:disposeNorms
          outputLineSets:&lineSets
                 barSets:&barSets
              candleSets:&candleSets];
    if (!lineSets.count && !barSets.count && !candleSets.count){
        if (isMain){
            _mainChartData = nil;
        }else{
            _helpChartData = nil;
        }
        return;
    }else{
        
        if (isMain && !_mainChartData){
            _mainChartData = [[CombinedChartData alloc] init];
        }else if (!isMain && !_helpChartData){
            _helpChartData = [[CombinedChartData alloc] init];
        }
    }
    
    CombinedChartData *disposeData = isMain ? _mainChartData : _helpChartData;
    if (!disposeData){return; }
    
    
    [self __setupLineSets:lineSets barSets:barSets candleSets:candleSets forDisposeData:disposeData];
}


- (void)__setupLineSets:(NSArray<LineChartDataSet *> *)lineSets
                barSets:(NSArray<BarChartDataSet *> *)barSets
             candleSets:(NSArray<CandleChartDataSet *> *)candleSets
                forDisposeData:(CombinedChartData *)disposeData
{
    if (lineSets.count){
        if (!disposeData.lineData){
            disposeData.lineData = [[LineChartData alloc] initWithDataSets:lineSets];
        }else{
            [disposeData.lineData setDataSets:lineSets];
        }
    }else{
        disposeData.lineData = nil;
    }
    
    if (barSets.count){
        if (!disposeData.barData){
            disposeData.barData = [[BarChartData alloc] initWithDataSets:barSets];
            disposeData.barData.barWidth = 1.0 - KLBarSpaceValue;
        }else{
            [disposeData.barData setDataSets:barSets];
        }
    }else{
        disposeData.barData = nil;
    }
    
    if (candleSets.count){
        if (!disposeData.candleData){
            disposeData.candleData = [[CandleChartData alloc] initWithDataSets:candleSets];
        }else{
            [disposeData.candleData setDataSets:candleSets];
        }
    }else{
        disposeData.candleData = nil;
    }
}

- (void)__disposeNorms:(NSArray<id<KLNorm>> *)norms
        outputLineSets:(NSArray<LineChartDataSet *> **)lineSets
               barSets:(NSArray<BarChartDataSet *> **)barSets
            candleSets:(NSArray<CandleChartDataSet *> **)candleSets
{
    if (!norms.count) return;
    
    NSMutableArray<LineChartDataSet *> *lineDataSets = [NSMutableArray array];
    NSMutableArray<BarChartDataSet *> *barDataSets = [NSMutableArray array];
    NSMutableArray<CandleChartDataSet *> *candleDataSets = [NSMutableArray array];

    for (id<KLNorm> aNorm in norms) {

        if (aNorm.lineSets.count){
            [lineDataSets addObjectsFromArray:aNorm.lineSets];
        }
        if (aNorm.barSets.count){
            [barDataSets addObjectsFromArray:aNorm.barSets];
        }
        if (aNorm.candleSets.count){
            [candleDataSets addObjectsFromArray:aNorm.candleSets];
        }
    }
    if (lineDataSets.count && lineSets) {
        *lineSets = [NSArray arrayWithArray:lineDataSets];
    }
    if (barDataSets.count && barSets) {
        *barSets = [NSArray arrayWithArray:barDataSets];
    }
    if (candleDataSets.count && candleSets) {
        *candleSets = [NSArray arrayWithArray:candleDataSets];
    }
}
- (BOOL)isEqualChartDataLhs:(CombinedChartData *)lhs rhs:(CombinedChartData *)rhs
{
    if (lhs == nil && rhs == nil) { return YES; }
    else if (lhs != nil && rhs != nil){
        return [lhs isEqual:rhs];
    }
    else{
        return NO;
    }
}

- (id<KLNorm>)__findVisibleMainNorm
{
    for (id<KLNorm> aNorm in self.dataHolder.mainNorms) {
        if([self __isVisibleMainNorm:aNorm]){
            return aNorm;
        }
    }
    return nil;
}
- (id<KLNorm>)__findVisibleHelpNorm
{
    for (id<KLNorm> aNorm in self.dataHolder.helpNorms) {
        if([self __isVisibleHelpNorm:aNorm]){
            return aNorm;
        }
    }
    return nil;
}
- (BOOL)__isVisibleMainNorm:(id<KLNorm>)norm
{
    if (_mainVisible == KLNormVisibleMain_None) return NO;
    else if ([KLNormVisibleMainRawValue(_mainVisible) isEqualToString:norm.name]) return YES;

    return NO;
}
- (BOOL)__isVisibleHelpNorm:(id<KLNorm>)norm
{
    if (_helpVisible == KLNormVisibleHelp_None) return NO;
    else if ([KLNormVisibleHelpRawValue(_helpVisible) isEqualToString:norm.name]) return YES;
    return NO;
}

@end
