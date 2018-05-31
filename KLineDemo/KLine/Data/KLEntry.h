//
//  KLEntry.h
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLChartDataEntry.h"
#import "KLCandleChartDataEntry.h"

@interface KLEntryBase : NSObject
@property (nonatomic) CGFloat y;
@property (nonatomic,strong) id data;
@end

@interface KLEntry : KLEntryBase

@property (nonatomic) CGFloat high;
@property (nonatomic) CGFloat low;
@property (nonatomic) CGFloat open;
@property (nonatomic) CGFloat close;

@property (nonatomic) CGFloat vol;//成交量

@property (nonatomic,copy) NSString *timestamp;//时间戳

- (BOOL)isUsable;

@end
