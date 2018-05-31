//
//  KLChartDataHolder.h
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLNorm.h"
#import "KLNormConfiguration.h"

@class KLChartDataHolder;
@protocol KLChartDataHolderDelegate<NSObject>

- (void)dataHolder:(KLChartDataHolder *)dataHolder didRefreshSetsIsResetting:(BOOL)resetting;

@end

/// 存放所有指标
@interface KLChartDataHolder : NSObject

@property (nonatomic,weak) id<KLChartDataHolderDelegate> delagete;

@property (nonatomic,strong,readonly) id<KLNorm> fixedNorm;
@property (nonatomic,strong,readonly) NSArray<id<KLNorm>> *mainNorms;
@property (nonatomic,strong,readonly) NSArray<id<KLNorm>> *helpNorms;

- (void)addEntry:(KLEntry *)e;

- (void)setEntries:(NSArray<KLEntry *> *)entries;

@end

