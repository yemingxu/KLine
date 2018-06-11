//
//  ViewController.m
//  KLineDemo
//
//  Created by JoeXu on 2018/5/24.
//  Copyright © 2018年 KL. All rights reserved.
//

#import "ViewController.h"
#import "KLChartView.h"
#import "YMJSONObject.h"

static inline KLEntry *__convertEntry(NSArray *rawObject,int index)
{
    
    KLEntry *e = [[KLEntry alloc] init];
    e.timestamp = [NSString stringWithFormat:@"%f",[rawObject[0] doubleValue]];
    e.vol = [rawObject[1] floatValue];
    e.open = [rawObject[2] floatValue] * 100.0;;
    e.close = [rawObject[5] floatValue] * 100.0;;
    e.high = [rawObject[3] floatValue] * 100.0;;
    e.low = [rawObject[4] floatValue] * 100.0;;
    return e;
}
@interface ViewController ()
@property (nonatomic,strong) KLChartView *chartView;;
@property (nonatomic,strong) NSArray *jsonObject;;


@property (strong, nonatomic) IBOutlet UIButton *MAButton;
@property (strong, nonatomic) IBOutlet UIButton *BOLLButton;



@property (strong, nonatomic) IBOutlet UIButton *VOLButton;
@property (strong, nonatomic) IBOutlet UIButton *MACDButton;
@property (strong, nonatomic) IBOutlet UIButton *KDJButton;
@property (strong, nonatomic) IBOutlet UIButton *RSIButton;

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = (CGSize){self.view.frame.size.width,self.view.frame.size.height*2.0};
//    [self.view addSubview:_scrollView];
    
    CGRect chartFrame = (CGRect){
        0,
        100,
        self.view.frame.size.width,
        400};
    _chartView = [[KLChartView alloc] initWithFrame:chartFrame];
    _jsonObject = [YMJSONObject getObjects];
    
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:_jsonObject.count];
    for (int i = 0; i<_jsonObject.count/3.0; i++) {
        NSArray *rawObject = _jsonObject[i];
        tmp[i] = __convertEntry(rawObject,i);
    }
    [_chartView.dataHolder setEntries:tmp];
    [self.view addSubview:_chartView];
    
    __block int currentIdx = _jsonObject.count/3.0;
    __weak typeof(self) self_weak = self;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 60.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (self_weak == nil) return ;
//        return;
        if (currentIdx >= self_weak.jsonObject.count-1){
            dispatch_cancel(timer);
            return;
        }
        currentIdx++;
        [self_weak.chartView.dataHolder addEntry: __convertEntry(self_weak.jsonObject[currentIdx],currentIdx)];
        
    });
    dispatch_resume(timer);
    
//    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__tapClicked:)];
//    [self.view addGestureRecognizer:tap];
    
}
- (void)__tapClicked:(UILongPressGestureRecognizer *)tap
{
    
//    if (self.chartView.dataHandler.selectedOtherNorm){
//        [self.chartView hideOtherNorm];
//    }else{
//        [self.chartView showOtherNorm:self.chartView.dataHandler.otherNorms.lastObject];
//    }
    
}

- (IBAction)mainMAClicked:(UIButton *)sender {

    
    self.chartView.dataVisible.mainVisible = KLNormVisibleMain_MA;

    [self __selectedMain:sender];
}
- (IBAction)mainBOLLClicked:(UIButton *)sender {
    
    
    self.chartView.dataVisible.mainVisible = KLNormVisibleMain_BOLL;

    [self __selectedMain:sender];
}


- (IBAction)otherVOLClicked:(UIButton *)sender {

    self.chartView.dataVisible.helpVisible = KLNormVisibleHelp_Vol;

    [self __selectedHelp:sender];
}

- (IBAction)helpMACDClicked:(UIButton *)sender {
    
    self.chartView.dataVisible.helpVisible = KLNormVisibleHelp_MACD;

    [self __selectedHelp:sender];
    
}
- (IBAction)helpKDJClicked:(UIButton *)sender {
    
    self.chartView.dataVisible.helpVisible = KLNormVisibleHelp_KDJ;
    
    [self __selectedHelp:sender];
    
}
- (IBAction)helpRSIClicked:(UIButton *)sender {
    
    self.chartView.dataVisible.helpVisible = KLNormVisibleHelp_RSI;
    
    [self __selectedHelp:sender];
    
}
- (void)__selectedHelp:(UIButton *)sender
{
    for (UIButton *button in @[self.VOLButton,self.MACDButton,self.KDJButton,self.RSIButton]) {
        button.selected = [button isEqual:sender];
    }
}


- (void)__selectedMain:(UIButton *)sender
{
    for (UIButton *button in @[self.MAButton,self.BOLLButton]) {
        button.selected = [button isEqual:sender];
    }
}
@end



