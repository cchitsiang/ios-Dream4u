//
//  AppDelegate.h
//  Dream4u
//
//  Created by Lam Si Mon on 12/6/14.
//  Copyright (c) 2014 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,PPRevealSideViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property ( nonatomic , strong ) PPRevealSideViewController *revealVC;

@end

