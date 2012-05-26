//
//  FlipsideViewController.m
//  MaxSMS
//
//  Created by Maxwell Swadling on 28/11/10.
//  Copyright 2010 Maxwell Swadling. All rights reserved.
//

#import "MSFlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate;

@synthesize username;
@synthesize password;
@synthesize sentFrom;
@synthesize oneMessage;

@synthesize usernameBox;
@synthesize passwordBox;
@synthesize messageSwitch;
@synthesize sentText;

- (void)updateSettings {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:[usernameBox text] forKey:@"username_preference"];
	[defaults setObject:[passwordBox text] forKey:@"password_preference"];
	[defaults setBool:[messageSwitch isOn] forKey:@"single_sms_preference"];
    [defaults setObject:[sentText text] forKey:@"sent_preference"];
    
	[defaults synchronize]; // this method is optional
	
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
}


- (IBAction)done:(id)sender {
	[self updateSettings];
	
	[self.delegate flipsideViewControllerDidFinish:self];	
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
