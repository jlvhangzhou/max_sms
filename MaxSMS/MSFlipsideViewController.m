//
//  FlipsideViewController.m
//  MaxSMS
//
//  Created by Maxwell Swadling on 28/11/10.
//  Copyright 2010 Maxwell Swadling. All rights reserved.
//

#import "MSFlipsideViewController.h"

#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"

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
@synthesize creditRemaining;

- (void)textFieldDidEndEditing:(UITextField *)textField {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  if (textField == usernameBox) {
      [defaults setObject:[usernameBox text] forKey:@"username_preference"];
  } else if (textField == passwordBox) {
      [defaults setObject:[passwordBox text] forKey:@"password_preference"];
  } else if (textField == sentText) {
      [defaults setObject:[sentText text] forKey:@"sent_preference"];
      AppDelegate.sentFromText.text = [sentText text];
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
    
    // TODO: this shouldn't exist at all. Use viewdidappear: to get and set values.
    AppDelegate.sentFromText2 = sentText;

    // on toggle, call toggle_message
    [messageSwitch addTarget:self action:@selector(toggle_message) forControlEvents:UIControlEventValueChanged];
    
    // Send a request for current usage    
    // username, password, country = AU
    // returns CREDITS:8658.44;COUNTRY:AU;SMS:3764.54;
    // or returns some error stuff...
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                          username, @"user",
                          password, @"password",
                          @"AU", @"country",
                          nil];
    
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://www.smsglobal.com/"]];
    NSMutableURLRequest *request = [client requestWithMethod:@"GET" path:@"credit-api.php" parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Object 1 at index is the country, not useful.
        NSArray *vals = [[operation responseString] componentsSeparatedByString:@";"];
        
        creditRemaining.text = [NSString stringWithFormat:@"%@ / %@", [vals objectAtIndex:0], [vals objectAtIndex:2]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [operation error]);
    }];
    
    [operation start];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [self setCreditRemaining:nil];
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



@end
