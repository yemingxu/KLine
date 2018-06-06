//
//  KLXAxisValuesFormatter.h
//  KLineDemo
//
//  Created by JoeXu on 2018/6/6.
//  Copyright © 2018年 KL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLSwiftDefines.h"
#import "KLChartDataHolder.h"

@interface KLXAxisValuesFormatter : NSObject<IChartAxisValueFormatter>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataHolder:(KLChartDataHolder *)dataHolder;

@end
