//
//  Checklist.h
//  KaoYan
//
//  Created by sherlock de Mac mini on 14-5-26.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property(nonatomic,strong) NSMutableArray *items;

@property(nonatomic,copy)NSString *iconName;


-(int)countUncheckedItems;

@end
