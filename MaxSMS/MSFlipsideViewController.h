//
//  FlipsideViewController.h
//  MaxSMS
//
//  Created by Maxwell Swadling on 28/11/10.
//  Copyright 2010 Maxwell Swadling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipsideViewController : UIViewController <UITextFieldDelegate> {
	
	UITextField *usernameBox;
	UITextField *passwordBox;
	UISwitch *messageSwitch;
	
	NSString *username;
	NSString *password;
	BOOL oneMessage;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic) BOOL oneMessage;
@property (nonatomic, retain) NSString *sentFrom;

@property (nonatomic, retain) IBOutlet UITextField *usernameBox;
@property (nonatomic, retain) IBOutlet UITextField *passwordBox;
@property (nonatomic, retain) IBOutlet UISwitch *messageSwitch;
@property (retain, nonatomic) IBOutlet UITextField *sentText;

@end

