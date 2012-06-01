//
//  MaxSMSAppDelegate.h
//  MaxSMS
//
//  Created by Maxwell Swadling on 28/11/10.
//  Copyright 2010 Maxwell Swadling. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RESIGN_(e) if ([e isFirstResponder] && [touch view] != e)\
  { [e resignFirstResponder]; }

@interface MSAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UITabBarController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *mainViewController;

@end

