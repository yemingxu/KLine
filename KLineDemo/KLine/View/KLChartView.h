//
//  KLChartView.h
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLChartDataHolder.h"
#import "KLChartDataVisible.h"

@interface KLChartView : UIView

@property (nonatomic,assign) CGFloat helpChartHeight;//副图高度 - 默认80

@property (nonatomic,strong,readonly) KLChartDataHolder *dataHolder;
@property (nonatomic,strong,readonly) KLChartDataVisible *dataVisible;


@end
