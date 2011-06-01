//
//  pickerResistorAppDelegate.m
//  pickerResistor
//
//  Created by Tarei on 16/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "pickerResistorAppDelegate.h"
#import "pickerResistorViewController.h"

@implementation pickerResistorAppDelegate


@synthesize window=_window;

@synthesize viewController=_viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

@end
