//
//  MainViewController.h
//  MaxSMS
//
//  Created by Maxwell Swadling on 28/11/10.
//  Copyright 2010 Maxwell Swadling. All rights reserved.
//

#import "MSFlipsideViewController.h"


#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface MainViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate> {
	UIButton *sendButton;
	UITextField *phoneNumber;
	UITextView *messageBox;
	NSMutableData *receivedData;
	UIAlertView *alert;
}

@property (nonatomic, weak) IBOutlet UIButton *sendButton;
@property (nonatomic, weak) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *sentFrom;
@property (nonatomic, weak) IBOutlet UITextView *messageBox;

@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) UIAlertView *alert;

- (IBAction)lookupContact:(id)sender;
- (IBAction)sendMessage:(id)sender;

@end
