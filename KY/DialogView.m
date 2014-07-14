//
//  DialogView.m
//  KY
//
//  Created by sherlock de Mac mini on 14-6-27.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import "DialogView.h"

@implementation DialogView{
    UIButton *button;
    UILabel *label;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithRed:25.0f/255.0f green:180.0f/255.0f blue:255.0f/255.0f alpha:1]]; //设置视图背景颜色
        self.layer.cornerRadius = 5;    //设置弹出框为圆角视图
        self.layer.masksToBounds = YES;
        
        //button
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(110,350, 100, 50)];
        [button addTarget:self action:@selector(closeClickButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1;
        button.layer.cornerRadius = 5;
        button.layer.shadowOffset =  CGSizeMake(3, 5);
        button.layer.shadowOpacity = 0.8;
        button.layer.shadowColor = [UIColor blackColor].CGColor;
        [button setTitleColor:[UIColor whiteColor ]forState:UIControlStateNormal];
        
        [self addSubview:button];
        
        //label
        label = [[UILabel alloc]initWithFrame:CGRectMake(0,80, 320, 120)];
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont  fontWithName:@"TrebuchetMS-Bold" size:30];
        //label1.font =  [UIFont
         //               boldSystemFontOfSize:30];
     
        [self addSubview:label];
        
    }
    return self;
}

-(IBAction)closeClickButton:(id)sender{
    NSLog(@"关闭视图");
    //self.hidden=YES;
    [self removeFromSuperview];
}

-(void)isSucceed
{
    [button setTitle:@"Good job" forState:UIControlStateNormal];
    label.text = @"学习成功，\n请继续努力！";
}

-(void)isfailed
{
    [button setTitle:@"失败" forState:UIControlStateNormal];
    label.text = @"学习失败，\n请不要玩手机!";
}


@end
