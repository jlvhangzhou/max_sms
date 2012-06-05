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

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic) BOOL oneMessage;
@property (nonatomic, strong) NSString *sentFrom;

@property (nonatomic, strong) IBOutlet UITextField *usernameBox;
@property (nonatomic, strong) IBOutlet UITextField *passwordBox;
@property (nonatomic, strong) IBOutlet UISwitch *messageSwitch;
@property (strong, nonatomic) IBOutlet UITextField *sentText;
@property (weak, nonatomic) IBOutlet UILabel *creditRemaining;

@end

