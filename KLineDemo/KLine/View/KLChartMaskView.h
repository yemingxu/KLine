//
//  KLChartMaskView.h
//  KLineDemo
//
//  Created by JoeXu on 2018/6/11.
//  Copyright © 2018年 KL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLSwiftDefines.h"

@interface KLChartMaskView : UIView
{
    @package CGFloat _candleBarWidth;
    @package ChartDataEntry *_highlightEntry;
    @package CGPoint _candleHighlightEntryPt;
}

- (void)cleanDraw;

@end
