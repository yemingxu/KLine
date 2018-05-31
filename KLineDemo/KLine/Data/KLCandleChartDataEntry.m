//
//  KLCandleChartDataEntry.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLCandleChartDataEntry.h"

@implementation KLCandleChartDataEntry

- (CGFloat)y
{
    return (self.high + self.low)/2.0;
}
- (void)setY:(CGFloat)y{}

@end
