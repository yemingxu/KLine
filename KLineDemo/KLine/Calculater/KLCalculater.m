//
//  KLCalculater.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLCalculater.h"
#import <mach/mach.h>

@implementation KLCalculater

+ (BOOL)calcEntries:(KLEntries *)entries
       outputCandle:(KLCandleChartDataEntries *__autoreleasing *)candle
          timeshare:(KLChartDataEntries *__autoreleasing *)timeshare
                vol:(KLBarChartDataEntries *__autoreleasing *)vol
                MA5:(KLChartDataEntries *__autoreleasing *)MA5
               MA10:(KLChartDataEntries *__autoreleasing *)MA10
               MA30:(KLChartDataEntries *__autoreleasing *)MA30
               MA60:(KLChartDataEntries *__autoreleasing *)MA60
              EMA12:(KLChartDataEntries *__autoreleasing *)EMA12
              EMA26:(KLChartDataEntries *__autoreleasing *)EMA26
           MACD_DIF:(KLChartDataEntries *__autoreleasing *)MACD_DIF
           MACD_DEA:(KLChartDataEntries *__autoreleasing *)MACD_DEA
           MACD_BAR:(KLBarChartDataEntries *__autoreleasing *)MACD_BAR
            BOLL_MB:(KLChartDataEntries *__autoreleasing *)BOLL_MB
            BOLL_UP:(KLChartDataEntries *__autoreleasing *)BOLL_UP
            BOLL_DN:(KLChartDataEntries *__autoreleasing *)BOLL_DN
              KDJ_K:(KLChartDataEntries *__autoreleasing *)KDJ_K
              KDJ_D:(KLChartDataEntries *__autoreleasing *)KDJ_D
              KDJ_J:(KLChartDataEntries *__autoreleasing *)KDJ_J
               RSI6:(KLChartDataEntries *__autoreleasing *)RSI6
              RSI12:(KLChartDataEntries *__autoreleasing *)RSI12
              RSI24:(KLChartDataEntries *__autoreleasing *)RSI24
{
    
    if (!entries.count) return NO;
    
    KLCandleChartDataMutableEntries *out_candle;if (candle){out_candle = [NSMutableArray array];}
    KLChartDataMutableEntries *out_timeshare;if (timeshare){out_timeshare = [NSMutableArray array];}
    KLBarChartDataMutableEntries *out_vol;if (vol){out_vol = [NSMutableArray array];}
    KLChartDataMutableEntries *out_MA5;if (MA5){out_MA5 = [NSMutableArray array];}
    KLChartDataMutableEntries *out_MA10;if (MA10){out_MA10 = [NSMutableArray array];}
    KLChartDataMutableEntries *out_MA30;if (MA30){out_MA30 = [NSMutableArray array];}
    KLChartDataMutableEntries *out_MA60;if (MA60){out_MA60 = [NSMutableArray array];}
    KLChartDataMutableEntries *out_EMA12;if (EMA12){out_EMA12 = [NSMutableArray array];}
    KLChartDataMutableEntries *out_EMA26;if (EMA26){out_EMA26 = [NSMutableArray array];}
    KLChartDataMutableEntries *out_MACD_DIF;
    if (MACD_DIF){
        out_MACD_DIF = out_MACD_DIF ?: [NSMutableArray array];
        out_EMA12 = out_EMA12 ?: [NSMutableArray array];
        out_EMA26 = out_EMA26 ?: [NSMutableArray array];
    }
    KLChartDataMutableEntries *out_MACD_DEA;
    if (MACD_DEA){
        out_MACD_DEA = out_MACD_DEA ?: [NSMutableArray array];
        out_MACD_DIF = out_MACD_DIF ?: [NSMutableArray array];
        out_EMA12 = out_EMA12 ?: [NSMutableArray array];
        out_EMA26 = out_EMA26 ?: [NSMutableArray array];
    }
    KLBarChartDataMutableEntries *out_MACD_BAR;
    if (MACD_BAR){
        out_MACD_BAR = out_MACD_BAR ?: [NSMutableArray array];
        out_MACD_DEA = out_MACD_DEA ?: [NSMutableArray array];
        out_MACD_DIF = out_MACD_DIF ?: [NSMutableArray array];
        out_EMA12 = out_EMA12 ?: [NSMutableArray array];
        out_EMA26 = out_EMA26 ?: [NSMutableArray array];
    }
    
    /// BOLL
    KLChartDataMutableEntries *out_BOLL_MB;if (BOLL_MB){out_BOLL_MB = [NSMutableArray array];}
    KLChartDataMutableEntries *out_BOLL_UP;if (BOLL_UP){out_BOLL_UP = [NSMutableArray array];}
    KLChartDataMutableEntries *out_BOLL_DN;if (BOLL_DN){out_BOLL_DN = [NSMutableArray array];}
    int n_boll = 20;

    /// KDJ
    KLChartDataMutableEntries *out_KDJ_K;if (KDJ_K){out_KDJ_K = [NSMutableArray array];}
    KLChartDataMutableEntries *out_KDJ_D;if (KDJ_D){out_KDJ_D = [NSMutableArray array];}
    KLChartDataMutableEntries *out_KDJ_J;if (KDJ_J){out_KDJ_J = [NSMutableArray array];}
    int n_kdj = 9;

    /// RSI
    KLChartDataMutableEntries *out_RSI6;if (RSI6){out_RSI6 = [NSMutableArray array];}
    KLChartDataMutableEntries *out_RSI12;if (RSI12){out_RSI12 = [NSMutableArray array];}
    KLChartDataMutableEntries *out_RSI24;if (RSI24){out_RSI24 = [NSMutableArray array];}

    
    for (NSUInteger i = 0; i<entries.count; i++) {
        KLEntry *e = entries[i];
        
        /// Base
        if (out_candle){
            [out_candle addObject:__CandleChartDataEntryFrom(e, i)];
        }
        if (out_timeshare){
            [out_timeshare addObject:__TimeShareChartDataEntryFrom(e, i)];
        }
        if (out_vol){
            [out_vol addObject:__VolBarChartDataEntryFrom(e, i)];
        }
        
        /// MA
        if (out_MA5 && i >= 5-1){
            [out_MA5 addObject:__MA_N_ChartDataEntryFrom(entries,5,i)];
        }
        if (out_MA10 && i >= 10-1){
            [out_MA10 addObject:__MA_N_ChartDataEntryFrom(entries, 10,i)];
        }
        if (out_MA30 && i >= 30-1){
            [out_MA30 addObject:__MA_N_ChartDataEntryFrom(entries, 30,i)];
        }
        if (out_MA60 && i >= 60-1){
            [out_MA60 addObject:__MA_N_ChartDataEntryFrom(entries, 60,i)];
        }
        
        /// MACD
        if (out_EMA12 && i >= 12-1){
            [out_EMA12 addObject:__EMA_N_ChartDataEntryFrom(entries, 12, out_EMA12.lastObject, i)];
        }
        if (out_EMA26 && i >= 26-1){
            [out_EMA26 addObject:__EMA_N_ChartDataEntryFrom(entries, 26, out_EMA26.lastObject, i)];
        }
        
        if (out_MACD_DIF && out_EMA26.count && out_EMA12.count){
            NSUInteger EMA12_find_idx = i-(12-1);
            NSUInteger EMA26_find_idx = i-(26-1);
            [out_MACD_DIF addObject:__DIF_ChartDataEntryFrom(out_EMA12[EMA12_find_idx],out_EMA26[EMA26_find_idx],i)];
        }
        
        if (out_MACD_DEA && out_MACD_DIF.count >= 9){
            [out_MACD_DEA addObject:__DEA_ChartDataEntryFrom(out_MACD_DIF, i)];
        }
        if (out_MACD_BAR && out_MACD_DEA.count > 0){
            NSUInteger DIF_find_idx = i-(26-1);
            NSUInteger DEA_find_idx = i-(26+8-1);
            [out_MACD_BAR addObject:__MACDBAR_ChartDataEntryFrom(out_MACD_DIF[DIF_find_idx],out_MACD_DEA[DEA_find_idx], i)];
        }
        
        /// BOLL
        if (out_BOLL_MB && i >= n_boll){
            [out_BOLL_MB addObject:__MB_N_ChartDataEntryFrom(entries, n_boll, i)];
        }
        if (out_BOLL_UP && i >= n_boll){
            [out_BOLL_UP addObject:__UP_N_ChartDataEntryFrom(entries, n_boll, i)];
        }
        if (out_BOLL_DN && i >= n_boll){
            [out_BOLL_DN addObject:__DN_N_ChartDataEntryFrom(entries, n_boll, i)];
        }
        
        if ((out_KDJ_K || out_KDJ_D || out_KDJ_J) &&
            i >= n_kdj){//从n_kdj开始产生第一个有意义的K
            
            ChartDataEntry *_K;
            ChartDataEntry *_D;
            ChartDataEntry *_J;
            if (__KDJ_N_ChartDataEntryFrom(entries,
                                           out_KDJ_K.lastObject,
                                           out_KDJ_D.lastObject,
                                           out_KDJ_J.lastObject,
                                           &_K,
                                           &_D,
                                           &_J,
                                           n_kdj,
                                           i)){
                if (_K){
                    [out_KDJ_K addObject:_K];
                }
                if (_D){
                    [out_KDJ_D addObject:_D];
                }
                if (_J){
                    [out_KDJ_J addObject:_J];
                }
            }
        }
        
        /// RSI
        if (out_RSI6 && i >= 6-1){
            ChartDataEntry *rsi_e = __RSI_N_ChartDataEntryFrom(entries, 6,i);
            if (rsi_e){
                [out_RSI6 addObject:rsi_e];
            }
        }
        if (out_RSI12 && i >= 12-1){
            ChartDataEntry *rsi_e = __RSI_N_ChartDataEntryFrom(entries, 12,i);
            if (rsi_e){
                [out_RSI12 addObject:rsi_e];
            }
        }
        if (out_RSI24 && i >= 24-1){
            ChartDataEntry *rsi_e = __RSI_N_ChartDataEntryFrom(entries, 24,i);
            if (rsi_e){
                [out_RSI24 addObject:rsi_e];
            }
        }
        
    }
    
    
    if (candle && out_candle.count){*candle = [NSArray arrayWithArray:out_candle];}
    if (timeshare && out_timeshare.count){*timeshare = [NSArray arrayWithArray:out_timeshare];}
    if (vol && out_vol.count){*vol = [NSArray arrayWithArray:out_vol];}
    
    if (MA5 && out_MA5.count){*MA5 = [NSArray arrayWithArray:out_MA5];}
    if (MA10 && out_MA10.count){*MA10 = [NSArray arrayWithArray:out_MA10];}
    if (MA30 && out_MA30.count){*MA30 = [NSArray arrayWithArray:out_MA30];}
    if (MA60 && out_MA60.count){*MA60 = [NSArray arrayWithArray:out_MA60];}
    
    if (EMA12 && out_EMA12.count){*EMA12 = [NSArray arrayWithArray:out_EMA12];}
    if (EMA26 && out_EMA26.count){*EMA26 = [NSArray arrayWithArray:out_EMA26];}
    if (MACD_DIF && out_MACD_DIF.count){*MACD_DIF = [NSArray arrayWithArray:out_MACD_DIF];}
    if (MACD_DEA && out_MACD_DEA.count){*MACD_DEA = [NSArray arrayWithArray:out_MACD_DEA];}
    if (MACD_BAR && out_MACD_BAR.count){*MACD_BAR = [NSArray arrayWithArray:out_MACD_BAR];}
    
    if (BOLL_MB && out_BOLL_MB.count){*BOLL_MB = [NSArray arrayWithArray:out_BOLL_MB];}
    if (BOLL_UP && out_BOLL_UP.count){*BOLL_UP = [NSArray arrayWithArray:out_BOLL_UP];}
    if (BOLL_DN && out_BOLL_DN.count){*BOLL_DN = [NSArray arrayWithArray:out_BOLL_DN];}
    
    if (KDJ_K && out_KDJ_K.count){*KDJ_K = [NSArray arrayWithArray:out_KDJ_K];}
    if (KDJ_D && out_KDJ_D.count){*KDJ_D = [NSArray arrayWithArray:out_KDJ_D];}
    if (KDJ_J && out_KDJ_J.count){*KDJ_J = [NSArray arrayWithArray:out_KDJ_J];}
    
    
    if (RSI6 && out_RSI6.count){*RSI6 = [NSArray arrayWithArray:out_RSI6];}
    if (RSI12 && out_RSI12.count){*RSI12 = [NSArray arrayWithArray:out_RSI12];}
    if (RSI24 && out_RSI24.count){*RSI24 = [NSArray arrayWithArray:out_RSI24];}
    
    return YES;
}

static CandleChartDataEntry *__CandleChartDataEntryFrom(KLEntry *e,NSUInteger x)
{
    return [[CandleChartDataEntry alloc] initWithX:x shadowH:e.high shadowL:e.low open:e.open close:e.close];
}

static ChartDataEntry *__TimeShareChartDataEntryFrom(KLEntry *e,NSUInteger x)
{
    return [[ChartDataEntry alloc] initWithX:x y:e.y];
}

static BarChartDataEntry *__VolBarChartDataEntryFrom(KLEntry *e,NSUInteger x)
{
    return [[BarChartDataEntry alloc] initWithX:x y:e.vol];
}



/**
 MA(x) = (E(x).close + E(x-1).close ...)/n
 取 从x开始倒数，n个收盘价的平均值
 */
static ChartDataEntry *__MA_N_ChartDataEntryFrom(KLEntries *entries,NSUInteger n,NSUInteger x)
{
    if (__IS_CAN_VERAGE(entries,n,x) == NO) return nil;

    CGFloat sum = 0.0;
    int flag = 0;
    while (flag < n) {
        sum += entries[x-flag].y;
        flag++;
    }
    CGFloat y = sum/(n * 1.0);
    return [[ChartDataEntry alloc] initWithX:x y:y];
}


/**
 α 平滑指数，一般取作2/(n+1)
 EMA(x) = α * (E(x).y - EMA(x-1)) + EMA(x-1);
 第一个的EMA默认为 当前的收盘价
 */
static ChartDataEntry *__EMA_N_ChartDataEntryFrom(KLEntries *entries,NSUInteger n,ChartDataEntry *lastE,NSUInteger x)
{
    if (__IS_CAN_VERAGE(entries,n,x) == NO) return nil;

    CGFloat α = 2.0/(n+1);//平滑指数，一般取作2/(N+1)
    CGFloat lastEMA = 0.0;
    CGFloat thisEMA = 0.0;
    
    CGFloat thisY = entries[x].y;
    
    if (lastE == nil){
        thisEMA = thisY;
    }else{
        lastEMA = lastE.y;
        thisEMA = α * (thisY - lastEMA) + lastEMA;
    }
    return [[ChartDataEntry alloc] initWithX:x y:thisEMA];
}

/**
 DIF(x) = (EMA12(x) - EMA26(x));
 */
static ChartDataEntry *__DIF_ChartDataEntryFrom(ChartDataEntry *EMA12_e,ChartDataEntry *EMA26_e,NSUInteger x)
{
    if (!EMA12_e || !EMA26_e) return nil;
    
    CGFloat y = (EMA12_e.y - EMA26_e.y);
    return [[ChartDataEntry alloc] initWithX:x y:y];
}

/**
 DEA(x) = (DIF(x) + DIF(x-1) ...)/9.0;
 */
static ChartDataEntry *__DEA_ChartDataEntryFrom(KLChartDataMutableEntries *DIF,NSUInteger x)
{
    if (DIF.count < 9) return nil;
    
    CGFloat sum = 0.0;
    int flag = 0;
    while (flag < 9) {
        sum += DIF[DIF.count-flag-1].y;
        flag++;
    }
    CGFloat y = sum/9.0;
    return [[ChartDataEntry alloc] initWithX:x y:y];
}

/**
 BAR(x) = (DIF(x) - DEA(x));
 */
static BarChartDataEntry *__MACDBAR_ChartDataEntryFrom(ChartDataEntry *DIF_e,ChartDataEntry *DEA_e,NSUInteger x)
{
    if (!DIF_e || !DEA_e) return nil;
    
    CGFloat y = (DIF_e.y - DEA_e.y);
    return [[BarChartDataEntry alloc] initWithX:x y:y];
}


/**
 MB(x) = MA(x-1)
 */
static ChartDataEntry *__MB_N_ChartDataEntryFrom(KLEntries *entries,NSUInteger n,NSUInteger x)
{
    return __MA_N_ChartDataEntryFrom(entries, n, x-1);
}
/**
 UP(x) = MB(x) + (2.0 * MD(x))
 */
static ChartDataEntry *__UP_N_ChartDataEntryFrom(KLEntries *entries,NSUInteger n,NSUInteger x)
{
    ChartDataEntry *_MB_N = __MB_N_ChartDataEntryFrom(entries, n, x);
    if (!_MB_N) return nil;
    CGFloat _MD_N = __MD_N_From(entries, n, x);
    CGFloat _UP_N_y = _MB_N.y + (2.0 * _MD_N);
    return [[ChartDataEntry alloc] initWithX:x y:_UP_N_y];
}
/**
 DN(x) = MB(x) - (2.0 * MD(x))
 */
static ChartDataEntry *__DN_N_ChartDataEntryFrom(KLEntries *entries,NSUInteger n,NSUInteger x)
{
    ChartDataEntry *_MB_N = __MB_N_ChartDataEntryFrom(entries, n, x);
    if (!_MB_N) return nil;
    CGFloat _MD_N = __MD_N_From(entries, n, x);
    CGFloat _DN_N_y = _MB_N.y - (2.0 * _MD_N);
    return [[ChartDataEntry alloc] initWithX:x y:_DN_N_y];
}

/**
 K(n) = K(n-1) * (2.0/3.0) + RSV(n) * (1.0/3.0);
 D(n) = D(n-1) * (2.0/3.0) + K(n) * (1.0/3.0);
 J(n) = (K(n) * 3.0) - (D(n) * 2.0);

 第一个真正的K,要从n+1开始算( K(n)的默认值为50.0)。
 第一个真正的D,要从n+2开始算( D(n-1)的默认值为50.0)。
 第一个真正的J,要从n+2开始算
 */
static BOOL __KDJ_N_ChartDataEntryFrom(KLEntries *entries,
                                       ChartDataEntry *last_K,
                                       ChartDataEntry *last_D,
                                       ChartDataEntry *last_J,
                                       ChartDataEntry **out_K,
                                       ChartDataEntry **out_D,
                                       ChartDataEntry **out_J,
                                       NSUInteger n,
                                       NSUInteger x)
{
    
    if(x < n) return NO;
    CGFloat rsv_n = __RSV_N_From(entries, n, x);
    if (rsv_n < 0) return NO;
    
    /// K
    CGFloat last_K_y;
    if (x == n){
        last_K_y = 50.0;
    }else{
        if (!last_K) return NO;
        last_K_y = [last_K y];
    }
    CGFloat now_K_y = (2.0/3.0)*last_K_y + (1.0/3.0)*rsv_n;
    if (out_K){
        *out_K = [[ChartDataEntry alloc] initWithX:x y:now_K_y];
    }
    
    /// D
    CGFloat last_D_y;
    if (x == n){
        return YES;
    }else if(x == n+1){
        last_D_y = 50.0;
    }else{
        if (!last_D) return NO;
        last_D_y = [last_D y];
    }
    
    CGFloat now_D_y = last_D_y * (2.0/3.0) + last_K_y * (1.0/3.0);
    if (out_D){
        if (!last_K) return NO;
        *out_D = [[ChartDataEntry alloc] initWithX:x y:now_D_y];
        
        /// J
        if (*out_K && *out_D && out_J){
            CGFloat now_J_y = (now_K_y * 3.0) - (now_D_y * 2.0);
            *out_J = [[ChartDataEntry alloc] initWithX:x y:now_J_y];
        }
    }
    
    return YES;
}


/**
 
 */
static ChartDataEntry *__RSI_N_ChartDataEntryFrom(KLEntries *entries,NSUInteger n,NSUInteger x)
{
    if (__IS_CAN_VERAGE(entries,n,x) == NO) return nil;
    
    CGFloat up_sum = 0.0;//涨总和
    CGFloat dn_sum = 0.0;//跌总和
    
    for (int i = 0; i<n; i++) {
        KLEntry *e = entries[entries.count-i-1];
        if (e.close > e.open){
            up_sum += (e.close - e.open);
        }else{
            dn_sum += (e.open - e.close);
        }
    }

    CGFloat dn = (dn_sum/n);
    CGFloat up = (up_sum/n);
    if (dn == 0.0) return nil;
    CGFloat rs = (up/dn);
    CGFloat RSI_N_y = 100.0 - (100.0/(1 + rs));
    return [[ChartDataEntry alloc] initWithX:x y:RSI_N_y];
}

#pragma mark - Util Static Func

static BOOL __IS_CAN_VERAGE(KLEntries *entries,NSUInteger n,NSUInteger x)
{
    // 从0开始 所以x至少从n-1开始（entries.count 至少要有n个）
    return !(n <= 0 || n-1 > x || !entries.count || n > entries.count );
}

/**
 MD(x) = √(
 (
 (C(x) - MA(x))^2 + (C(x-1) - MA(x-1))^2 + (C(x-2) - MA(x-2))^2 ...
 )/n
 )
 */
static CGFloat __MD_N_From(KLEntries *entries,NSUInteger n,NSUInteger x)
{
    if (__IS_CAN_VERAGE(entries,n,x) == NO) return 0.0;

    CGFloat sum = 0.0;
    for (NSUInteger i = 0; i < n; i++) {
        KLEntry *kl_e = entries[x-i];
        ChartDataEntry *_MA_N = __MA_N_ChartDataEntryFrom(entries, n, x-i);
        if (_MA_N == nil) break;
        CGFloat c_ma = kl_e.y - _MA_N.y;
        sum += powf(c_ma,2);
    }
    return sqrt(sum/(n * 1.0));
}

/**
 RSV(9)=（今日收盘价－9日内最低价）÷（9日内最高价－9日内最低价）×100
 */
static CGFloat __RSV_N_From(KLEntries *entries,NSUInteger n,NSUInteger x)
{
    if (__IS_CAN_VERAGE(entries,n,x) == NO) return -100.0;//RSV 正常应在0~100之间;
    
    CGFloat min_y_n = CGFLOAT_MAX;
    CGFloat max_y_n = CGFLOAT_MIN;
    CGFloat close = 0.0;
    for (int i = (int)x; i>=0; i--) {
        KLEntry *kl_e = (entries[i]);
        
        min_y_n = MIN(min_y_n, kl_e.low);
        max_y_n = MAX(max_y_n, kl_e.high);
        if (i == x){
            close = kl_e.close;
        }
    }
    CGFloat rsv = ( (close - min_y_n) / (max_y_n - min_y_n) ) * 100.0;
    return rsv;
}


#pragma mark - 小数点精确 Decimal

static CGFloat  __Decimal(CGFloat number,short scale)
{
    if (isnan(number)) return 0.0;
    
    NSDecimalNumberHandler *behavior = __NSDecimalNumberHandler(scale);
    
    @autoreleasepool {
        NSString *string = [NSString stringWithFormat:@"%f",number];
        NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:string];
        decimalNumber = [decimalNumber decimalNumberByRoundingAccordingToBehavior:behavior];
        return decimalNumber.floatValue;
    }
}
static CGFloat  __Decimal_3(CGFloat number)
{
    if (isnan(number)) return 0.0;
    
    NSDecimalNumberHandler *behavior = __NSDecimalNumberHandler_3();
    
    @autoreleasepool {
        NSString *string = [NSString stringWithFormat:@"%f",number];
        NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:string];
        decimalNumber = [decimalNumber decimalNumberByRoundingAccordingToBehavior:behavior];
        return decimalNumber.floatValue;
    }
}

static NSDecimalNumberHandler * __NSDecimalNumberHandler_3()
{
    static dispatch_once_t onceToken;
    static NSDecimalNumberHandler *hander;
    dispatch_once(&onceToken, ^{
        hander = __NSDecimalNumberHandler(3);
    });
    return hander;
}
static NSDecimalNumberHandler * __NSDecimalNumberHandler(short scale)
{
    return [NSDecimalNumberHandler
            decimalNumberHandlerWithRoundingMode:NSRoundBankers
            scale:scale
            raiseOnExactness:NO
            raiseOnOverflow:NO
            raiseOnUnderflow:NO
            raiseOnDivideByZero:YES];
}
@end
