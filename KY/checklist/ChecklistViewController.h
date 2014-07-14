//
//  ChecklistsViewController.h
//  KaoYan
//
//  Created by sherlock de Mac mini on 14-5-26.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;

@interface ChecklistViewController : UITableViewController <ItemDetailViewControllerDelegate>

@property (nonatomic, strong) Checklist *checklist;

@end
