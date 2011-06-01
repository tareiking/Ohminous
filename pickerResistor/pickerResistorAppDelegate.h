//
//  pickerResistorAppDelegate.h
//  pickerResistor
//
//  Created by Tarei on 16/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class pickerResistorViewController;

@interface pickerResistorAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet pickerResistorViewController *viewController;

@end
