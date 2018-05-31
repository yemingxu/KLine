//
//  KLNorm.h
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLSwiftDefines.h"
#import "KLCalculatedResult.h"


@protocol KLNorm;
@protocol KLNormDelegate<NSObject>

- (void)kl_norm:(id<KLNorm>)norm didRefreshSetsWithResetting:(BOOL)resetting;

@end

@protocol KLNorm<NSObject>

@property (nonatomic,copy) NSString *name;
@property (nonatomic,weak) id<KLNormDelegate> delagete;

@property (nonatomic,copy,readonly) NSArray<LineChartDataSet *> *lineSets;

@property (nonatomic,copy,readonly) NSArray<BarChartDataSet *> *barSets;

@property (nonatomic,copy,readonly) NSArray<CandleChartDataSet *> *candleSets;

- (void)addLineSet:(LineChartDataSet *)lineSet;
- (void)addBarSet:(BarChartDataSet *)barSet;
- (void)addCandleSet:(CandleChartDataSet *)candleSet;
- (void)clearSets;
/// 为避免重复计算 - set的值，由指标计算器在外部计算完成 然后将结果传入各个指标，再由
/// 各个指标按需取值
- (void)updateSetsWithCalculatedResult:(KLCalculatedResult *)calcResult isResetting:(BOOL)isResetting;

@end

@interface KLNorm : NSObject<KLNorm>

- (void)resetSetsWithCalculatedResult:(KLCalculatedResult *)calcResult;

- (void)addDataEntryToSetsWithCalculatedResult:(KLCalculatedResult *)calcResult;

@end



@interface KLNorm (SetGenerate)

+ (LineChartDataSet *)generateBasalLineChartDataSet;

+ (BarChartDataSet *)generateBasalBarChartDataSet;

+ (CandleChartDataSet *)generateBasalCandleChartDataSet;


/// 为保持X坐标轴同步，保证X坐标轴起点X都以0.0开始
/// 需设置一个x为0.0的占位set
+ (LineChartDataSet *)spaceChartDataSet:(CGFloat)y;

@end



@interface KLNorm (EaseMake)

+ (instancetype)norm;

+ (instancetype)normWithName:(NSString *)name;

@end
