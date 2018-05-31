//
//  KLEntry.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLEntry.h"
#import "KLCandleChartDataEntry.h"
#import "KLUtilDefines.h"

@implementation KLEntryBase

@end

@implementation KLEntry

- (CGFloat)y
{
    return self.close;
}
- (void)setY:(CGFloat)y{}

- (BOOL)isUsable
{
    if (!self.timestamp.length) return NO;
    else if (self.vol < 0) return NO;
    
    if (self.high != KLMAX(self.high, self.low,self.open,self.close) ||
        self.low != KLMIN(self.high, self.low,self.open,self.close)) return NO;
    
    return YES;
}

@end
