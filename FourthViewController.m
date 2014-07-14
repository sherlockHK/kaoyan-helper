//
//  FourthViewController.m
//  KaoYan
//
//  Created by sherlock de Mac mini on 14-5-26.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import "FourthViewController.h"
#import "DialogView.h"

@interface FourthViewController ()
{
    MZTimerLabel *timer;
    NSTimeInterval countDownTime; //倒计时时间
    CMMotionManager *cmManager;//手机动作管理
    DialogView *_dialogView;
}

@property (strong,nonatomic) ADBannerView *adView;
@property (nonatomic,assign)BOOL bannerIsVisible;

@end

@implementation FourthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    timer = [[MZTimerLabel alloc] initWithLabel:self.countDownLabel andTimerType:MZTimerLabelTypeTimer];
    countDownTime = 0;
    [timer setCountDownTime:countDownTime];
    timer.delegate = self;
    
    self.countDownLabel.hidden = YES;
    self.cancelButton.hidden = YES;
    self.TenSecondsCountDownView.hidden = YES;
    
    //AD
    self.adView = [[ADBannerView alloc]initWithFrame:CGRectMake(0, 518, 320, 50)];
    self.adView.delegate = self;
    [self.view addSubview:self.adView];
    
    //弹出视图
    _dialogView = [[DialogView alloc] initWithFrame:CGRectMake(0, 64, 320, 454)];
   
}

-(void)viewDidUnload{
    self.adView.delegate = nil;
}

#pragma mark - AD delegate
-(void) bannerViewDidLoadAd:(ADBannerView *)banner
{
    if(!self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        banner.frame = CGRectMake(0, 518, 320, 50);
        [UIView commitAnimations];
        self.bannerIsVisible =YES;
        NSLog(@"AD success!");
    }
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if(self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        banner.frame = CGRectMake(0, 618, 320, 50);
        [UIView commitAnimations];
        self.bannerIsVisible =NO;
        NSLog(@"AD failed!");
    }
}


- (IBAction)startStudy{
    
    [self performSelector:@selector(begin) withObject:nil afterDelay:5];
    self.titleLable.text = @"您有5秒钟来准备";
    
    countDownTime = self.timePicker.countDownDuration;
    [timer setCountDownTime:countDownTime];
    self.timePicker.hidden = YES;
    self.countDownLabel.hidden = NO;
    self.startButton.hidden = YES;
    self.cancelButton.hidden = NO;
    
    //倒计时动画
    if (self.TenSecondsCountDownView.hidden == YES) {
        self.TenSecondsCountDownView.hidden = NO;
        NSLog(@"unhide");
    }
    self.TenSecondsCountDownView.delegate = self;
    self.TenSecondsCountDownView.backgroundAlpha = 0.1;
    self.TenSecondsCountDownView.countdownColor = [UIColor blackColor];
    self.TenSecondsCountDownView.countdownFrom = 5;
    self.TenSecondsCountDownView.finishText = @"Go!";
    [self.TenSecondsCountDownView updateAppearance];
    [self.TenSecondsCountDownView start];
    
}

//开始复习计时，并且检测手机动作
-(void)begin{
    [timer start];
    self.titleLable.text = @"开始复习";
    self.startButton.enabled = NO;
    self.cancelButton.enabled = NO;
    self.cancelButton.hidden = YES;
    
    //motion detect
    cmManager = [[CMMotionManager alloc]init];
    if (!cmManager.accelerometerAvailable) {
        NSLog(@"CMMotionManager unavailable");
    }
    
    cmManager.accelerometerUpdateInterval = 1;
    
    [cmManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        double x = accelerometerData.acceleration.x;
        double y = accelerometerData.acceleration.y;
        double z = accelerometerData.acceleration.z;
        
        //检测到移动，弹出复习失败图像
        if(fabs(x)>0.5 || fabs(y)>0.6 || fabs(z)>1){
            NSLog(@"检测到手机移动!");
            [_dialogView isfailed];
            [self.view addSubview:_dialogView];
            
            [cmManager stopAccelerometerUpdates];
            [timer reset];
            [timer pause];
            [self.TenSecondsCountDownView stop];
            
            self.TenSecondsCountDownView.hidden = YES;
            self.cancelButton.enabled = YES;
            self.startButton.enabled = YES;
            self.titleLable.text = @"要复习了吗？";
            self.timePicker.hidden = NO;
            self.startButton.hidden = NO;
            self.cancelButton.hidden = YES;
            self.countDownLabel.hidden = YES;
            NSLog(@"fialed");
        }
    }];
}

-(IBAction)cancel{
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(begin) object:nil];
    
    self.TenSecondsCountDownView.hidden = YES;
    [self.TenSecondsCountDownView stop];
    //[self.TenSecondsCountDownView removeFromSuperview];
    NSLog(@"cancel");
    
    self.titleLable.text = @"要复习了吗？";
    self.timePicker.hidden = NO;
    self.startButton.hidden = NO;
    self.cancelButton.hidden = YES;
    self.countDownLabel.hidden = YES;
}

#pragma mark - delegate methods
//完成学习倒计时
- (void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime
{
    [cmManager stopAccelerometerUpdates];
    NSLog(@"完成学习倒计时!!");
    [_dialogView isSucceed];
    [self.view addSubview:_dialogView];
    
    self.timePicker.hidden = NO;
    self.countDownLabel.hidden = YES;
    self.startButton.hidden = NO;
    self.cancelButton.hidden = YES;
    self.startButton.enabled = YES;
    self.cancelButton.enabled = YES;
        
}

//完成10秒准备倒计时
- (void)countdownFinished:(SFCountdownView *)view{
     self.TenSecondsCountDownView.hidden = YES;
}



@end

