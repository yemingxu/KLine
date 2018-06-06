//
//  KLNorm.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLNorm.h"
#import "KLUtilDefines.h"

@interface KLNorm()
{
    NSMutableArray *_lineSets;
    NSMutableArray *_barSets;
    NSMutableArray *_candleSets;

}
@end
@implementation KLNorm
@synthesize name = _name;
@synthesize delagete = _delagete;
@synthesize lineSets = _lineSets;
@synthesize barSets = _barSets;
@synthesize candleSets = _candleSets;

- (instancetype)init
{
    self = [super init];
    if (self){
    }
    return self;
}

- (void)updateSetsWithCalculatedResult:(KLCalculatedResult *)calcResult isResetting:(BOOL)isResetting
{
    if (isResetting){
        [self resetSetsWithCalculatedResult:calcResult];
    }else{
        [self addDataEntryToSetsWithCalculatedResult:calcResult];
    }
    
    if ([self.delagete respondsToSelector:@selector(kl_norm:didRefreshSetsWithResetting:)]){
        [self.delagete kl_norm:self didRefreshSetsWithResetting:isResetting];
    }
}

- (void)resetSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{
    
    NSAssert(NO, @"子指标类重写");
    
}

- (void)addDataEntryToSetsWithCalculatedResult:(KLCalculatedResult *)calcResult
{

    NSAssert(NO, @"子指标类重写");

}

- (NSArray<LineChartDataSet *> *)lineSets
{
    return [NSArray arrayWithArray:_lineSets];
}
- (NSArray<BarChartDataSet *> *)barSets
{
    return [NSArray arrayWithArray:_barSets];
}
- (NSArray<CandleChartDataSet *> *)candleSets
{
    return [NSArray arrayWithArray:_candleSets];
}

- (void)addLineSet:(LineChartDataSet *)lineSet
{
    if (!lineSet || ![lineSet isKindOfClass:[LineChartDataSet class]]) return;
    
    if (!_lineSets) {
        _lineSets = [NSMutableArray array];
    }
    
    [_lineSets addObject:lineSet];
}
- (void)addBarSet:(BarChartDataSet *)barSet
{
    if (!barSet || ![barSet isKindOfClass:[BarChartDataSet class]]) return;
    
    if (!_barSets) {
        _barSets = [NSMutableArray array];
    }
    
    [_barSets addObject:barSet];
}
- (void)addCandleSet:(CandleChartDataSet *)candleSet
{
    if (!candleSet || ![candleSet isKindOfClass:[CandleChartDataSet class]]) return;
    
    if (!_candleSets) {
        _candleSets = [NSMutableArray array];
    }
    
    [_candleSets addObject:candleSet];
}
- (void)clearSets
{
    [_lineSets removeAllObjects];
    [_barSets removeAllObjects];
    [_candleSets removeAllObjects];
}
@end




@implementation KLNorm (SetGenerate)

+ (LineChartDataSet *)generateBasalLineChartDataSet
{
    LineChartDataSet *set = [[LineChartDataSet alloc] init];
    set.axisDependency = AxisDependencyRight;
    set.lineWidth = 1.0f;
    set.drawValuesEnabled = NO;
    set.drawSteppedEnabled = NO;
    set.drawCirclesEnabled = NO;
    set.circleRadius = 1.0f;
    set.circleHoleRadius = 1.0f;
    set.highlightEnabled = NO;
    set.valueFont = [UIFont systemFontOfSize:12];
    set.mode = LineChartModeLinear;
//    set.drawFilledEnabled = ([algorithmKey isEqual:_mainLineAlgorithm]); // 是否显示折线图阴影
    return set;
}

+ (BarChartDataSet *)generateBasalBarChartDataSet
{
    BarChartDataSet *set = [[BarChartDataSet alloc] init];
    set.axisDependency = AxisDependencyRight;
    set.drawValuesEnabled = NO;
    set.highlightEnabled = NO;
    set.valueFont = [UIFont systemFontOfSize:12];
    
    return set;
}

+ (CandleChartDataSet *)generateBasalCandleChartDataSet
{
    // Candle
    CandleChartDataSet *set = [[CandleChartDataSet alloc] init];
    set.axisDependency = AxisDependencyRight;
    set.highlightEnabled = NO;
    [set setColor:KLGoUpColor];
    //这是用于显示最高最低值区间的立线
    set.shadowColor = KLGoUpColor;
    set.shadowColorSameAsCandle = YES;
    //不在面板上直接显示数值
    set.drawValuesEnabled = NO;
    // 立线的宽度
    set.shadowWidth = 1;
    // close >= open
    set.increasingColor = KLGoUpColor;
    // 内部是否充满颜色
    set.decreasingFilled = true;
    // open > close
    set.decreasingColor = KLGoDownColor;
    
    // 内部是否充满颜色
    set.increasingFilled = true;
    set.barSpace = KLBarSpaceValue/2.0;
    
    return set;
}

+ (LineChartDataSet *)spaceChartDataSet:(CGFloat)y
{
    ChartDataEntry *e = [[ChartDataEntry alloc] initWithX:0.0 y:y];
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:@[e]];
    set.axisDependency = AxisDependencyRight;
    set.visible = NO;
    return set;
}

@end



@implementation KLNorm (EaseMake)

+ (instancetype)norm
{
    return [[self alloc] init];
}

+ (instancetype)normWithName:(NSString *)name;
{
    KLNorm *norm = [[self alloc] init];
    norm.name = name;
    return norm;
}

@end


