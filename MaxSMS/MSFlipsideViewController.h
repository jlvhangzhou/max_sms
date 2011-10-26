//
//  FlipsideViewController.h
//  MaxSMS
//
//  Created by Maxwell Swadling on 28/11/10.
//  Copyright 2010 Maxwell Swadling. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController {
	id <FlipsideViewControllerDelegate> delegate;
	
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

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

