//
//  KLCandleChartDataEntry.h
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLChartDataEntry.h"
#import <CoreGraphics/CoreGraphics.h>

@interface KLCandleChartDataEntry : KLChartDataEntry

@property (nonatomic) CGFloat high;
@property (nonatomic) CGFloat low;
@property (nonatomic) CGFloat open;
@property (nonatomic) CGFloat close;

@end
