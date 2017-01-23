//
//  AppDelegate.h
//  MGActionSheetExample
//
//  Created by Luqiang on 2017/1/23.
//  Copyright © 2017年 Mango. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

