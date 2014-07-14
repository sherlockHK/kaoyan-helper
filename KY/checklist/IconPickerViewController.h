//
//  IconPickerViewController.h
//  KaoYan
//
//  Created by sherlock de Mac mini on 14-5-26.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerViewController;

@protocol IconPickerViewControllerDelegate <NSObject>

-(void)iconPicker:(IconPickerViewController*)picker didPickIcon:(NSString*)iconName;

@end

@interface IconPickerViewController : UITableViewController

@property(nonatomic,weak)id <IconPickerViewControllerDelegate> delegate;

@end
