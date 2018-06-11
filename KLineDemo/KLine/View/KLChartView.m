//
//  KLChartView.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/28.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "KLChartView.h"
#import "KLSwiftDefines.h"
#import "KLUtilDefines.h"
#import "KLXAxisValuesFormatter.h"
#import "KLChartMaskView.h"

@interface KLChartView()<ChartViewDelegate,KLChartDataVisibleDelegate>
{
    BOOL _needShowHelpChart;
    
    KLChartMaskView *_maskView;
}

@property (nonatomic,strong) CombinedChartView *mainChartView;//主图
@property (nonatomic,strong) CombinedChartView *helpChartView;//附属指标图

@end
@implementation KLChartView


-  (instancetype)init
{
    return [self initWithFrame:(CGRectZero)];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self __initialize];
        [self __loadUI];
        
        
        UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__longGesture:)];
        [self.mainChartView addGestureRecognizer:longGes];
    }
    return self;
}
- (void)__initialize
{
    _helpChartHeight = 80.0;
    _dataHolder = [[KLChartDataHolder alloc] init];
    _dataVisible = [[KLChartDataVisible alloc] init];
    [_dataVisible prepareWithDataHolder:_dataHolder];
    _dataVisible.delegate = self;

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self bringSubviewToFront:_maskView];
    _maskView.frame = self.bounds;
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self __layoutChartFrame];
}

#pragma mark - ChartViewDelegate
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-result"
- (void)chartScaled:(ChartViewBase *)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY
{
    [self syncChartsByTouchView:chartView];
}

- (void)chartTranslated:(ChartViewBase *)chartView dX:(CGFloat)dX dY:(CGFloat)dY
{
    [self syncChartsByTouchView:chartView];
}

- (void)chartWillDisplay:(ChartViewBase *)chartView
{
    [_maskView cleanDraw];
}

- (void)syncChartsByTouchView:(ChartViewBase *)chartView
{
    
    ChartViewBase *extraChartView;
    extraChartView = [chartView isEqual:self.mainChartView] ? self.helpChartView : self.mainChartView;
    
    CGAffineTransform srcMatrix = chartView.viewPortHandler.touchMatrix;
    [extraChartView.viewPortHandler refreshWithNewMatrix:srcMatrix
                                                   chart:extraChartView
                                              invalidate:YES];
}
#pragma clang diagnostic pop


#pragma mark - KLChartDataVisibleDelegate

- (void)dataVisibleRefreshedForReset:(KLChartDataVisible *)dataVisible
{
    self.mainChartView.data = dataVisible.mainChartData;
    self.helpChartView.data = dataVisible.helpChartData;
    
    [self.mainChartView zoomWithScaleX:KLBarVisibleMaxWidthPixel
                                scaleY:0.0
                                xValue:self.mainChartView.chartXMax
                                yValue:0
                                  axis:AxisDependencyRight];
    [self syncChartsByTouchView:self.mainChartView];
}

- (void)dataVisibleRefreshedForAddEntry:(KLChartDataVisible *)dataVisible
{
    if (self.mainChartView.data){
        [self.mainChartView notifyDataSetChanged];
    }else{
        self.mainChartView.data = dataVisible.mainChartData;
    }
    if (self.helpChartView.data){
        [self.helpChartView notifyDataSetChanged];
    }else{
        self.helpChartView.data = dataVisible.helpChartData;
    }
    
    [self syncChartsByTouchView:self.mainChartView];

}
- (void)dataVisibleRefreshedOfMainForNormChanged:(KLChartDataVisible *)dataVisible dataIsReset:(BOOL)dataIsReset
{
    self.mainChartView.data = dataVisible.mainChartData;
}
- (void)dataVisibleRefreshedOfHelpForNormChanged:(KLChartDataVisible *)dataVisible dataIsReset:(BOOL)dataIsReset
{
    BOOL needShowHelpChart = (dataVisible.helpVisible != KLNormVisibleHelp_None);
    if (_needShowHelpChart != needShowHelpChart){
        _needShowHelpChart = needShowHelpChart;
        [self __layoutChartFrame];
        self.helpChartView.data = dataVisible.helpChartData;
        [self syncChartsByTouchView:self.mainChartView];
    }
    self.helpChartView.data = dataVisible.helpChartData;
}

#pragma mark - 长按
- (void)__longGesture:(UILongPressGestureRecognizer *)longGes
{
    CGPoint touchPoint = [longGes locationInView:self.mainChartView];
    ChartHighlight *h = [self.mainChartView getHighlightByTouchPoint:touchPoint];
    if (h== nil) return;
    
    CandleChartDataEntry *e;
    
    CandleChartDataSet *set = (CandleChartDataSet *)[self.mainChartView.data getDataSetByIndex:h.dataSetIndex];
    if (set == nil || ![set isKindOfClass:[CandleChartDataSet class]]){
        
        set = (CandleChartDataSet *)self.mainChartView.candleData.dataSets.firstObject;
        e = (CandleChartDataEntry *)[set entryForXValue:h.x closestToY:h.y];
        
    }else{
        e = (CandleChartDataEntry *)[self.mainChartView.data entryForHighlight:h];
    }
    
    NSArray<ChartDataRendererBase *> *subRenderers = [(CombinedChartRenderer *)self.mainChartView.renderer subRenderers];
    CandleStickChartRenderer *candleRender;
    for (ChartDataRendererBase *anRender in subRenderers){
        if ([anRender isKindOfClass:[CandleStickChartRenderer class]]){
            candleRender = (CandleStickChartRenderer *)anRender;
        }
    }
    ChartTransformer *trans = [candleRender.dataProvider getTransformerForAxis:set.axisDependency];
    
    BOOL isCandleH = (set && [set isKindOfClass:[CandleChartDataSet class]]);
    CGFloat xPos = e.x;
    CGFloat barSpace =  isCandleH ? set.barSpace : 1.0;
    CGRect r = (CGRect){xPos - 0.5 + barSpace,0,1.0 - 2.0*barSpace,1};
    
    
    CGFloat barWidth = [trans ym_rectValueToPixel:r].size.width;
    CGPoint pt;
    if (isCandleH){
        pt = [trans pixelForValuesWithX:e.x y:[(CandleChartDataEntry *)e close]];
        _maskView->_highlightEntry = (CandleChartDataEntry *)e;
    }else{
        pt = [trans pixelForValuesWithX:e.x y:[(ChartDataEntry *)e y]];
        barWidth = 1.0;
        _maskView->_highlightEntry = nil;
    }
    
    _maskView->_candleBarWidth = barWidth;
    _maskView->_candleHighlightEntryPt = pt;
    [_maskView setNeedsDisplay];
}


#pragma mark - 公有

//高度
- (void)setHelpChartHeight:(CGFloat)otherHeight
{
    _helpChartHeight = otherHeight;
    [self __layoutChartFrame];
}


#pragma mark - 私有
- (void)__loadUI
{
    _maskView = [[KLChartMaskView alloc] initWithFrame:self.bounds];
    [self addSubview:_maskView];
    
    _mainChartView = [[CombinedChartView alloc] initWithFrame:self.bounds];
    [self __initializeChartView:_mainChartView];
    
    [self addSubview:_mainChartView];
    [self __layoutChartFrame];
}

- (void)__layoutChartFrame
{
    if (_mainChartView == nil) return;
    
    CGSize self_size = self.bounds.size;
    
    if (_needShowHelpChart){
        
        if (!_helpChartView){
            CombinedChartView *chartView = [[CombinedChartView alloc] initWithFrame:self.bounds];
            [self __initializeChartView:chartView];
            chartView.xAxis.enabled = NO;
            _helpChartView = chartView;
            [self addSubview:_helpChartView];
        }
        CGRect otherChartViewShouldFrame = (CGRect){
            0,
            self_size.height-self.helpChartHeight,
            self_size.width,
            self.helpChartHeight};
        if (!CGRectEqualToRect(otherChartViewShouldFrame, self.helpChartView.frame)){
            self.helpChartView.frame = otherChartViewShouldFrame;
        }
    }
    self.helpChartView.hidden = !_needShowHelpChart;
    CGFloat mainBottom = self_size.height;
    if (_needShowHelpChart){
        mainBottom -= self.helpChartView.bounds.size.height;
    }
    mainBottom = mainBottom > 0.0 ? mainBottom : 0.0;
    CGRect mainChartViewShouldFrame = (CGRect){
        0,
        0,
        self_size.width,
        mainBottom};
    if (!CGRectEqualToRect(mainChartViewShouldFrame, self.mainChartView.frame)){
        self.mainChartView.frame = mainChartViewShouldFrame;
    }
}


#pragma mark - 

- (void)__initializeChartView:(CombinedChartView *)chartView
{
    UIColor *grayColor = KLUIColorHex(0x131f30);
    chartView.extraTopOffset = 20.0;
    //    [chartView setExtraOffsetsWithLeft:0 top:10 right:0 bottom:0];
    //如果需要显示选中图表位置进行数据展示 需要设置代理 可选项
    chartView.delegate = self;
    chartView.backgroundColor = grayColor;
    
    chartView.autoScaleMinMaxEnabled = true;
    
    // 画板以及边框颜色
    chartView.gridBackgroundColor = [UIColor clearColor];
    chartView.borderColor = [UIColor clearColor];
    chartView.chartDescription.enabled = NO;
    chartView.legend.enabled = NO;
    chartView.pinchZoomEnabled = NO;
    chartView.scaleYEnabled = NO;
    //根据需要显示或隐藏边框以及画板
    chartView.drawGridBackgroundEnabled = YES;
    chartView.drawBordersEnabled = NO;
    chartView.dragDecelerationEnabled = YES;
    chartView.highlightPerTapEnabled = NO;
    chartView.doubleTapToZoomEnabled = NO;
    [self setupXAxis:chartView.xAxis];
    [self setupYAxis:chartView.rightAxis];
    chartView.leftAxis.enabled = NO;
    
    chartView.maxVisibleBarWidthPixel = KLBarVisibleMaxWidthPixel;
}

- (void)setupXAxis:(ChartXAxis *)xAxis
{
    xAxis.yOffset = 6;
    xAxis.avoidFirstLastClippingEnabled = YES;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    [xAxis setLabelCount:8 force:NO];
    
    xAxis.drawGridLinesEnabled = YES;
    xAxis.drawAxisLineEnabled = NO;
    xAxis.drawLabelsEnabled = YES;
    xAxis.labelTextColor = [UIColor whiteColor];
    
    xAxis.valueFormatter = [[KLXAxisValuesFormatter alloc] initWithDataHolder:_dataHolder];
    
}
- (void)setupYAxis:(ChartYAxis *)yAxis
{
    
    //设置y轴相关参数 将坐标轴显示在右边
    yAxis.labelCount = 3;
    yAxis.decimals = 6;
    yAxis.forceLabelsEnabled = YES;
    yAxis.drawGridLinesEnabled = YES;
    yAxis.drawAxisLineEnabled = NO;
    //label位置
    yAxis.labelPosition = YAxisLabelPositionInsideChart;
    //文字颜色
    yAxis.labelTextColor = KLWeakBlackColor;
    //文字字体
    yAxis.labelFont = [UIFont systemFontOfSize:10];
    
    yAxis.spaceBottom = 0;
    yAxis.spaceTop = 0;
    
    yAxis.drawTopYLabelEntryEnabled = YES;
    yAxis.drawBottomYLabelEntryEnabled = YES;
    
}


@end
