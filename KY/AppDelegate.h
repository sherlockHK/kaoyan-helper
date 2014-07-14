//
//  AppDelegate.h
//  KY
//
//  Created by sherlock de Mac mini on 14-6-23.
//  Copyright (c) 2014年 CCNU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) DataModel *dataModelInDelegate;
@end
