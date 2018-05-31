//
//  KLChartDataVisible.h
//  KLineDemo
//
//  Created by JoeXu on 2018/5/29.
//  Copyright © 2018年 KL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLNormConfiguration.h"
#import "KLChartDataHolder.h"

/// 对指标进行 显示筛选

@class KLChartDataVisible;
@protocol KLChartDataVisibleDelegate<NSObject>

/// 可显数据被重置(选择了不同的时间单位(1分钟/1小时/分时)导致源数据被重置)
- (void)dataVisibleRefreshedForReset:(KLChartDataVisible *)dataVisible;


/// 有新数据被添加
- (void)dataVisibleRefreshedForAddEntry:(KLChartDataVisible *)dataVisible;


/// 主图 指标切换
- (void)dataVisibleRefreshedOfMainForNormChanged:(KLChartDataVisible *)dataVisible dataIsReset:(BOOL)dataIsReset;

/// 副图 指标切换
- (void)dataVisibleRefreshedOfHelpForNormChanged:(KLChartDataVisible *)dataVisible dataIsReset:(BOOL)dataIsReset;;




@end

@interface KLChartDataVisible : NSObject

@property (nonatomic,weak) id<KLChartDataVisibleDelegate> delegate;

@property (nonatomic,assign) KLNormVisibleMain mainVisible;
@property (nonatomic,assign) KLNormVisibleHelp helpVisible;

@property (nonatomic,copy,readonly) CombinedChartData *mainChartData;
@property (nonatomic,copy,readonly) CombinedChartData *helpChartData;

@property (nonatomic,copy,readonly) KLChartDataHolder *dataHolder;

- (void)prepareWithDataHolder:(KLChartDataHolder *)dataHolder;

//- (void)visualise:(KLChartDataHolder *)dataHolder;

@end
