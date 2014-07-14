//
//  ChecklistItem.h
//  KaoYan
//
//  Created by sherlock de Mac mini on 14-5-26.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;


@property(nonatomic,copy)NSDate *dueDate;
@property(nonatomic,assign) BOOL shouldRemind;
@property(nonatomic,assign) NSInteger itemId;

- (void)toggleChecked;
-(void)scheduleNotification;

@end
