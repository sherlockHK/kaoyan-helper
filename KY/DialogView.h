//
//  DialogView.h
//  KY
//
//  Created by sherlock de Mac mini on 14-6-27.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DialogView : UIView


-(IBAction)closeClickButton:(id)sender;

-(void)isSucceed;
-(void)isfailed;

@end
