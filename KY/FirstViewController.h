//
//  FirstViewController.h
//  KaoYan
//
//  Created by sherlock de Mac mini on 14-5-26.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "CalendarDateUtil.h"
#import "UIBaseClass.h"
#import "ListDetailViewController.h"
#import "ChecklistItem.h"
#import "Checklist.h"

@class  DataModel;

@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ListDetailViewControllerDelegate>
{
    NSString* _timeString;
    
    NSString* _nowDateString;
    NSMutableArray* _btnArray;
    
    UIView* _cBSView;
    UIView* _cBPView;
    UIView* _cBMIView;
    UIView* _lBSView;
    UIView* _lBPView;
    UIView* _lBMIView;
    UIView* _rBSView;
    UIView* _rBPView;
    UIView* _rBMIView;
    
    UILabel* _bsLable;
    UILabel* _bpLable;
    UILabel* _weightLable;
    UILabel* _appointLable;
    UILabel* _healthLable;
    UILabel* _manageLable;
    
    UILabel* _bsLableR;
    UILabel* _bpLableR;
    UILabel* _weightLableR;
    UILabel* _appointLableR;
    UILabel* _healthLableR;
    
    UILabel* _bsLableL;
    UILabel* _bpLableL;
    UILabel* _weightLableL;
    UILabel* _appointLableL;
    UILabel* _healthLableL;
    
    UIScrollView* _scrollView;
    UIView* _dateView;
    UIView* _workView;
    
    int _scrollDate;                    // 滑动控制中间日期
    int _btnDate;
    
    int _changeWeek;                    //控制滑动日期
    int _btnSelectDate;                 //btn选择的位置
    UIView* _changeDateR;
    UIView* _changeWorkR;
    UIView* _changeDateL;
    UIView* _changeWorkL;
    NSMutableArray* _changeBtnArrayR;   //RView的Btn数组
    NSMutableArray* _changeBtnArrayL;   //LView的Btn数组
    
    int _mmMainFX;
    int _mmMainFY;
    int _vFX;
    int _vFY;
    
}

@property(nonatomic, retain)NSString* nowDateString;
@property(nonatomic, retain)UILabel* bsLable;
@property(nonatomic, retain)UILabel* bpLable;
@property(nonatomic, retain)UILabel* weightLable;
@property(nonatomic, retain)UILabel* appointLable;
@property(nonatomic, retain)UILabel* healthLable;
@property(nonatomic, retain)NSMutableArray* btnArray;
@property(nonatomic, retain)UIScrollView* scrollView;
@property(nonatomic, retain)UIView* dateView;
@property(nonatomic, retain)UIView* workView;

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic)DataModel *dataModel;



@end
