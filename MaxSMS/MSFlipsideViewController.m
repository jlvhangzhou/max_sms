//
//  FlipsideViewController.m
//  MaxSMS
//
//  Created by Maxwell Swadling on 28/11/10.
//  Copyright 2010 Maxwell Swadling. All rights reserved.
//

#import "MSFlipsideViewController.h"

#import "MSAppDelegate.h"


@implementation FlipsideViewController

@synthesize username;
@synthesize password;
@synthesize sentFrom;
@synthesize oneMessage;

@synthesize usernameBox;
@synthesize passwordBox;
@synthesize messageSwitch;
@synthesize sentText;

- (void)textFieldDidEndEditing:(UITextField *)textField {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  if (textField == usernameBox) {
    [defaults setObject:[usernameBox text] forKey:@"username_preference"];
  } else if (textField == passwordBox) {
    [defaults setObject:[passwordBox text] forKey:@"password_preference"];
  } else if (textField == sentText) {
    [defaults setObject:[sentText text] forKey:@"sent_preference"];
  }
  
	[defaults synchronize];
  
}

// toggle truncate messages
- (void)toggle_message {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setBool:[messageSwitch isOn] forKey:@"single_sms_preference"];
  [defaults synchronize];
}

- (void)viewDidLoad {
    // Load background
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"txture.png"]];
    
    [super viewDidLoad];
	
	// Load prefs
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
	username = [defaults stringForKey:@"username_preference"];
	password = [defaults stringForKey:@"password_preference"];
	oneMessage = [defaults boolForKey:@"single_sms_preference"];
	sentFrom = [defaults stringForKey:@"sent_preference"];
    
	[usernameBox setText:username];
	[passwordBox setText:password];
	[messageSwitch setOn:oneMessage];
  [sentText setText:sentFrom];
  
  // Make this the delegate for the editors
  usernameBox.delegate = self;
  passwordBox.delegate = self;
  sentText.delegate = self;
  
  // on toggle, call toggle_message
  [messageSwitch addTarget:self action:@selector(toggle_message) forControlEvents:UIControlEventValueChanged];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [self setSentText:nil];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
  UITouch *touch = [[event allTouches] anyObject];
  RESIGN_(usernameBox);
	RESIGN_(passwordBox);
  RESIGN_(sentText);
	
	[super touchesBegan:touches withEvent:event];
  
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (void)dealloc {
    [sentText release];
    [super dealloc];
}


@end
