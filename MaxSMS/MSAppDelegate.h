//
//  MSAppDelegate.h
//  MaxSMS
//
//  Created by Maxwell Swadling on 26/10/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSMainViewController;

@interface MSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MSMainViewController *mainViewController;

@end
