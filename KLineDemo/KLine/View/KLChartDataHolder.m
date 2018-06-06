//
//  KLChartDataHolder.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLChartDataHolder.h"
#import "KLCalculatedResult.h"
#import "KLFixedNorm.h"

@interface KLChartDataHolder()
{
    
    
    
}
@property (nonatomic,strong,readwrite) KLCalculatedResult *calcResult;

@end


@implementation KLChartDataHolder

- (instancetype)init
{
    self = [super init];
    if (self){
        _mainNorms = [KLNormConfiguration defaultMainNorms];
        _helpNorms = [KLNormConfiguration defaultHelpNorms];
        _fixedNorm = [KLFixedNorm normWithName:@"Main_Fixed_Norm"];
    }
    return self;
}

- (void)addEntry:(KLEntry *)e
{
    if (!_calcResult){
        [self setEntries:@[e]];
    }else{
        [KLCalculater calculateForAddEntriy:e toLastResult:_calcResult];

        [self __refreshSetsIsResetting:NO];

        if ([self.delagete respondsToSelector:@selector(dataHolder:didRefreshSetsIsResetting:)]){
            [self.delagete dataHolder:self didRefreshSetsIsResetting:NO];
        }
    }
}

- (void)setEntries:(NSArray<KLEntry *> *)entries
{
    _calcResult = [KLCalculater calculateEntries:entries];
    
    [self __refreshSetsIsResetting:YES];

    if ([self.delagete respondsToSelector:@selector(dataHolder:didRefreshSetsIsResetting:)]){
        [self.delagete dataHolder:self didRefreshSetsIsResetting:YES];
    }
}

- (void)__refreshSetsIsResetting:(BOOL)isResetting
{
    [self.fixedNorm updateSetsWithCalculatedResult:_calcResult isResetting:isResetting];
    for (id<KLNorm> aNorm in self.mainNorms) {
        [aNorm updateSetsWithCalculatedResult:_calcResult isResetting:isResetting];
    }
    for (id<KLNorm> aNorm in self.helpNorms) {
        [aNorm updateSetsWithCalculatedResult:_calcResult isResetting:isResetting];
    }
}




@end
