//
//  FourthViewController.h
//  KaoYan
//
//  Created by sherlock de Mac mini on 14-5-26.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "MZTimerLabel.h"
#import <CoreMotion/CoreMotion.h>
#import "SFCountdownView.h"
#import "iAd/iAd.h"

@interface FourthViewController : UIViewController<MZTimerLabelDelegate,SFCountdownViewDelegate,ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet SFCountdownView *TenSecondsCountDownView;


-(IBAction)startStudy;
-(IBAction)cancel;

@end
