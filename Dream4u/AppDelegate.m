//
//  AppDelegate.m
//  Dream4u
//
//  Created by Lam Si Mon on 12/6/14.
//  Copyright (c) 2014 Lam Si Mon. All rights reserved.
//

#import "AppDelegate.h"
#import "MainVC.h"
#import "PaymentVC.h"
#import "Function.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //glinter-mon-buyer@hotmail.com
    [[Function instance] prepareData];
    NSLog(@"Dataa : %@" ,[[Function instance] data]);
    
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentSandbox : @"AbM9LxC6e9uKenVbKlIsm5VIqXPP4jcFZohqi-6ucqzZ80yx1yVGyKU7Z_-h"}];

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //PaymentVC *viewController = [[PaymentVC alloc] init];
    MainVC *viewController = [[MainVC alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.revealVC = [[PPRevealSideViewController alloc] initWithRootViewController:navController];
    self.revealVC.delegate = self;
    
    self.window.rootViewController = self.revealVC;
    [self.window makeKeyAndVisible];
    
    if (PPSystemVersionGreaterOrEqualThan(7.0))
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:25.0/255.0 green:28.0/255.0 blue:27.0/255.0 alpha:1.0]];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }

    
    return YES;
}

#pragma mark - PPRevealSideViewController delegate

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller willPushController:(UIViewController *)pushedController {
    PPRSLog(@"%@", pushedController);
    //    [UIView animateWithDuration:0.3
    //                     animations:^{
    //                         _iOS7UnderStatusBar.alpha = 1.0;
    //                     }];
}

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller didPushController:(UIViewController *)pushedController {
    PPRSLog(@"%@", pushedController);
}

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller willPopToController:(UIViewController *)centerController {
    PPRSLog(@"%@", centerController);
    //    [UIView animateWithDuration:0.3
    //                     animations:^{
    //                         _iOS7UnderStatusBar.alpha = 0.0;
    //                     }];
}

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller didPopToController:(UIViewController *)centerController {
    PPRSLog(@"%@", centerController);
}

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller didChangeCenterController:(UIViewController *)newCenterController {
    PPRSLog(@"%@", newCenterController);
}

- (BOOL)pprevealSideViewController:(PPRevealSideViewController *)controller shouldDeactivateDirectionGesture:(UIGestureRecognizer *)gesture forView:(UIView *)view {
    return NO;
}

- (PPRevealSideDirection)pprevealSideViewController:(PPRevealSideViewController *)controller directionsAllowedForPanningOnView:(UIView *)view {
    //if ([view isKindOfClass:NSClassFromString(@"UIWebBrowserView")]) return PPRevealSideDirectionLeft | PPRevealSideDirectionRight;
    
    return PPRevealSideDirectionLeft;// | PPRevealSideDirectionRight | PPRevealSideDirectionTop | PPRevealSideDirectionBottom;
}

- (void)pprevealSideViewController:(PPRevealSideViewController *)controller didManuallyMoveCenterControllerWithOffset:(CGFloat)offset
{

}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
