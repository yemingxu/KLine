//
//  KLXAxisValuesFormatter.m
//  KLineDemo
//
//  Created by JoeXu on 2018/6/6.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLXAxisValuesFormatter.h"

@interface KLXAxisValuesFormatter()
{
    dispatch_semaphore_t _semaphore;
    NSMutableDictionary *_cachedValueStrings;
}
@property (nonatomic,strong) KLChartDataHolder *dataHolder;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;


@end
@implementation KLXAxisValuesFormatter

- (instancetype)initWithDataHolder:(KLChartDataHolder *)dataHolder
{
    self = [super init];
    if (self){
        _dataHolder = dataHolder;
        
        _semaphore = dispatch_semaphore_create(1);
        _cachedValueStrings = [NSMutableDictionary dictionary];
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"hh:mm";
    }
    return self;
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    int index = (int)value;
    if (index != value) return nil;
    NSString *cachedString = [self __cachedStringForValue:value];
    if (cachedString.length) return cachedString;
    
    if (value <= self.dataHolder.calcResult.entries.count-1){
        KLEntry *e = self.dataHolder.calcResult.entries[index];
        if (e.timestamp.length){
            NSTimeInterval timestamp = [e.timestamp doubleValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
            NSString *result = [_dateFormatter stringFromDate:date];
            if (result.length){
                [self __cacheString:result forValue:value];
            }
            return result.length ? result : nil;
        }
    }
    return nil;
    
}

- (NSString *)__cachedStringForValue:(double)value
{
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    NSString *result = _cachedValueStrings[@(value)];
    dispatch_semaphore_signal(_semaphore);
    return result;
}
- (void)__cacheString:(NSString *)string forValue:(double)value
{
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    _cachedValueStrings[@(value)] = string;
    dispatch_semaphore_signal(_semaphore);
}

@end
