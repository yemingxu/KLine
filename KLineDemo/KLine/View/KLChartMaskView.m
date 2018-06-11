//
//  KLChartMaskView.m
//  KLineDemo
//
//  Created by JoeXu on 2018/6/11.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLChartMaskView.h"
#import "KLUtilDefines.h"

@implementation KLChartMaskView

-  (instancetype)init
{
    return [self initWithFrame:(CGRectZero)];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    [super setUserInteractionEnabled:NO];
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (_highlightEntry == nil){
        return;
    }
    
    CGFloat candleBarWidth = _candleBarWidth;
    CGPoint pt = _candleHighlightEntryPt;
    //    CandleChartDataEntry *e = _candleHighlightEntry;
    if (candleBarWidth == 0.0 || CGPointEqualToPoint(pt, CGPointZero)) return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, KLWWeakBlackColor.CGColor);
    CGContextFillRect(context, (CGRect){pt.x-candleBarWidth/2.0,0,candleBarWidth,rect.size.height});
    
    CGContextSetStrokeColorWithColor(context, KLWWeakBlackColor.CGColor);
    const CGPoint points[] = {CGPointMake(0, pt.y),CGPointMake(rect.size.width, pt.y)};
    CGContextStrokeLineSegments(context, points, 1);
    
    
    CGContextRestoreGState(context);
    
}
- (void)cleanDraw
{
    _highlightEntry = nil;
    [self setNeedsDisplay];
}
@end
