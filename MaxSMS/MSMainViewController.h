//
//  MainViewController.h
//  MaxSMS
//
//  Created by Maxwell Swadling on 28/11/10.
//  Copyright 2010 Maxwell Swadling. All rights reserved.
//

#import "MSFlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	UIButton *sendButton;
	UITextField *phoneNumber;
	UITextView *messageBox;
	NSMutableData *receivedData;
	UIAlertView *alert;
}

@property (nonatomic, retain) IBOutlet UIButton *sendButton;
@property (nonatomic, retain) IBOutlet UITextField *phoneNumber;
@property (nonatomic, retain) IBOutlet UITextView *messageBox;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) UIAlertView *alert;

- (IBAction)showInfo:(id)sender;

- (IBAction)sendMessage:(id)sender;

@end
