//
//  MaxSMSAppDelegate.h
//  MaxSMS
//
//  Created by Maxwell Swadling on 28/11/10.
//  Copyright 2010 Maxwell Swadling. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AppDelegate ((MSAppDelegate *)[UIApplication sharedApplication].delegate)

#define RESIGN_(e) if ([e isFirstResponder] && [touch view] != e)\
  { [e resignFirstResponder]; }

@interface MSAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UITabBarController *mainViewController;
}

// The correct way is to use viewWillAppear:
//     this will be fired when the view is selected in the tab bar
// NEVER EVER DO ANYTHING LIKE THIS EVER
@property (nonatomic, weak) UITextField *sentFromText;
@property (nonatomic, weak) UITextField *sentFromText2;

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UITabBarController *mainViewController;

@end

