//
//  FirstViewController.m
//  KaoYan
//
//  Created by sherlock de Mac mini on 14-5-26.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import "FirstViewController.h"
#import "Checklist.h"
#import "ChecklistViewController.h"

#import "ChecklistItem.h"
#import "AppDelegate.h"
#import "DataModel.h"

@interface FirstViewController ()

@end

@implementation FirstViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // self.view.backgroundColor = [UIColor whiteColor];
    _mmMainFX = self.view.bounds.origin.x;
    _mmMainFY = [[UIBaseClass shareInstance] getViewFramOY];
    
    _scrollDate = 0;
    _btnDate = 0;
    
    [self initBase];
    [self initView];
    [self initDateView];
    
    self.dataModel = [[DataModel alloc]init];
    
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appdelegate.dataModelInDelegate = self.dataModel;
    
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMdd"];
    _timeString = [dateformat stringFromDate:[NSDate date]];
    
    
    //    _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_scrollDate + _btnDate]];
    
    
	// Do any additional setup after loading the view.
}




#pragma mark-
#pragma mark 一周日期（数字）和任务区的位置
-(void)initBase
{
    _btnArray = [[NSMutableArray alloc]init];
    _changeBtnArrayR = [[NSMutableArray alloc]init];
    _changeBtnArrayL = [[NSMutableArray alloc]init];
    
    _changeWeek = 0;
    _btnSelectDate = 0;
    
    
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, 122, 320, 40)];
    _dateView.backgroundColor = [UIColor clearColor];
    _dateView.userInteractionEnabled = NO;
    [self.view addSubview:_dateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{

    //当前日期(后期添加功能 点击回到today）
    
    NSDateFormatter *dateformat1=[[NSDateFormatter  alloc]init];
    [dateformat1 setDateFormat:@"yy年MM月"];
    NSString* dateStr1 = [dateformat1 stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_scrollDate + _btnDate]];
    NSString* yearLabelText = [[NSString alloc]initWithFormat:@"%@", dateStr1];
    
    NSDateFormatter *dateformat2=[[NSDateFormatter  alloc]init];
    [dateformat2 setDateFormat:@"dd号"];
    NSString* dateStr2 = [dateformat2 stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_scrollDate + _btnDate]];
    NSString* dateLabelText = [[NSString alloc]initWithFormat:@"%@", dateStr2];
    
    //左上角日期视图:2label+1button
    self.yearLabel.text = yearLabelText;
    self.yearLabel.textColor= [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    
    self.dateLabel.text = dateLabelText;
    
}


#pragma mark-
#pragma mark Date 一周日期（汉字）
-(void)initDateView
{
    for (int i = 0; i < 7; i++)
    {
        UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(320/7*i, 106, 320/7, 15)];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
        lab.backgroundColor = [UIColor clearColor];
        NSString* week;
        switch (i) {
            case 0:{
                week=@"周日";
                break;
            }
            case 1:{
                week=@"周一";
                break;
            }
            case 2:{
                week=@"周二";
                break;
            }
            case 3:{
                week=@"周三";
                break;
            }
            case 4:{
                week=@"周四";
                break;
            }
            case 5:{
                week=@"周五";
                break;
            }
            case 6:{
                week=@"周六";
                break;
            }
                
                
            default:
                break;
        }
        lab.text = [NSString stringWithFormat:@"%@",week];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lab];
    }
    
    NSMutableArray* tempArr = [self switchDay];
    
    for (int i = 0; i < 7; i++)
    {
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake(320/7*i, 0, 320/7, 40)];
        lab.titleLabel.font = [UIFont systemFontOfSize:20];
        [lab setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%ld",(long)[CalendarDateUtil getCurrentDay]]])
        {
            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lab setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            lab.tag = 0;
            _btnSelectDate = i;
        }
        [_btnArray addObject:lab];
        [_dateView addSubview:lab];
    }

}

-(NSMutableArray*)switchDay
{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    int head = 0;
    int foot = 0;
    switch ([self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]]) {
        case 1:{
            head = 0;
            foot = 6;
            break;
        }
        case 2:{
            head = 1;
            foot = 5;
            break;
        }
        case 3:{
            head = 2;
            foot = 4;
            break;
        }
        case 4:{
            head = 3;
            foot = 3;
            break;
        }
        case 5:{
            head = 4;
            foot = 2;
            break;
        }
        case 6:{
            head = 5;
            foot = 1;
            break;
        }
        case 7:{
            head = 6;
            foot = 0;
            break;
        }
            
            
        default:
            break;
    }
    
    NSLog(@"%d , %d", head, foot);
    
    //    NSLog(@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:-1]]);
    
    for (int i = -head; i < 0; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%ld", (long)[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:i]]];
        [array addObject:str];
    }
    
    [array addObject:[NSString stringWithFormat:@"%ld", (long)[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:0]]]];
    
    //sy 添加日期
    int tempNum = 1;
    for (int i = 0; i < foot; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%ld", (long)[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:tempNum]]];
        [array addObject:str];
        tempNum++;
    }
    
    NSLog(@"weekArray = %lu", (unsigned long)[array count]);
    
    return array;
}

-(NSInteger)weekDate:(NSDate*)date
{
    // 获取当前年月日和周几
    //    NSDate *_date=[NSDate date];
    NSCalendar *_calendar=[NSCalendar currentCalendar];
    NSInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *com=[_calendar components:unitFlags fromDate:date];
    NSString *_dayNum=@"";
    NSInteger dayInt = 0;
    switch ([com weekday]) {
        case 1:{
            _dayNum=@"日";
            dayInt = 1;
            break;
        }
        case 2:{
            _dayNum=@"一";
            dayInt = 2;
            break;
        }
        case 3:{
            _dayNum=@"二";
            dayInt = 3;
            break;
        }
        case 4:{
            _dayNum=@"三";
            dayInt = 4;
            break;
        }
        case 5:{
            _dayNum=@"四";
            dayInt = 5;
            break;
        }
        case 6:{
            _dayNum=@"五";
            dayInt = 6;
            break;
        }
        case 7:{
            _dayNum=@"六";
            dayInt = 7;
            break;
        }
            
            
        default:
            break;
    }
    
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyy年MM月dd日"];
    NSString* dateStr = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_scrollDate + _btnDate]];
    

    _nowDateString = [[NSString alloc]initWithFormat:@"%@", dateStr];

    NSLog(@"week = %@", _dayNum);
    
    return dayInt;
}

-(void)selectData:(id)sender
{
    UIButton* sendBtn = sender;
    NSLog(@"btn = %@", sendBtn.titleLabel.text);
    NSLog(@"btn.tag = %ld", (long)sendBtn.tag);
    
    for (int i = 0; i < [_btnArray count]; i++)
    {
        UIButton* tmpBtn = [_btnArray objectAtIndex:i];
        [tmpBtn setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if ([tmpBtn.titleLabel.text isEqualToString:sendBtn.titleLabel.text])
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
    if ([sendBtn.titleLabel.text isEqualToString:@"29"])
    {
        _bsLable.text = @"0";
        _bpLable.text = @"0";
    }
    else
    {
        _bsLable.text = @"0";
        _bpLable.text = @"0";
    }
    
    
    _btnDate = (int)sendBtn.tag;
    
    //按日期确定星期
    
    [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]];
    
    NSLog(@"%@",_nowDateString);
    
    
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMdd"];
    _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]]; // _scrollDate
    
}

#pragma mark -
#pragma mark setButtonTitle
-(void)setBtnTitle  // 修改Btn的日期
{
    int chooseInt = (int)([self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1);
    
    for (int i = 0; i < [_btnArray count]; i++)
    {
        [[_btnArray objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%ld",(long)[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
    }
}
-(void)setBtnTitleR
{
    int chooseInt = (int)([self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1);
    for (int i = 0; i < [_changeBtnArrayR count]; i++)
    {
        [[_changeBtnArrayR objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%ld",(long)[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
        
        UIButton* tmpBtn = [_changeBtnArrayR objectAtIndex:i];
        [tmpBtn setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (_btnSelectDate == i)
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
}
-(void)setBtnTitleL
{
    int chooseInt =(int)([self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1);
    for (int i = 0; i < [_changeBtnArrayL count]; i++)
    {
        [[_changeBtnArrayL objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%ld",(long)[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
        
        UIButton* tmpBtn = [_changeBtnArrayL objectAtIndex:i];
        [tmpBtn setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (_btnSelectDate == i)
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    }


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Checklist *checklist = self.dataModel.lists[indexPath.row];
    
    cell.textLabel.text = checklist.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    int count = [checklist countUncheckedItems];
    if([checklist.items count]==0){
        
        cell.detailTextLabel.text = @"没有任务";
    }else if(count ==0){
        cell.detailTextLabel.text =@"全部搞定";
    }else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d个未完成",[checklist countUncheckedItems]];
    }
    
    cell.imageView.image = [UIImage imageNamed:checklist.iconName];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.dataModel setIndexOfSelectedChecklist:indexPath.row];
    Checklist *checklist = self.dataModel.lists[indexPath.row];
    
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];
    [self.dataModel saveChecklists];
    
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowChecklist"]) {
        ChecklistViewController *controller = segue.destinationViewController;
        controller.checklist = sender;
    } else if ([segue.identifier isEqualToString:@"AddChecklist"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.checklistToEdit = nil;
    }
}

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist
{
    [self.dataModel.lists addObject:checklist];
    [self.dataModel saveChecklists];
    
    NSLog(@"%lu",(unsigned long)[self.dataModel.lists count]);
    //[self.dataModel sortChecklists];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist
{
    [self.dataModel saveChecklists];
  //  [self.dataModel sortChecklists];
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    
    Checklist *checklist = self.dataModel.lists[indexPath.row];
    controller.checklistToEdit = checklist;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}



@end
