//
//  MainViewController.m
//  MaxSMS
//
//  Created by Maxwell Swadling on 28/11/10.
//  Copyright 2010 Maxwell Swadling. All rights reserved.
//

#import "MSMainViewController.h"

#import "MSAppDelegate.h"

@implementation MainViewController

@synthesize sendButton;
@synthesize phoneNumber;
@synthesize messageBox;
@synthesize receivedData;
@synthesize alert;


#pragma mark LOL K


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
  UITouch *touch = [[event allTouches] anyObject];
  RESIGN_(messageBox);
	RESIGN_(phoneNumber);
	
	[super touchesBegan:touches withEvent:event];
  
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (void)dealloc {
  [super dealloc];
}


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
     self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"txture.png"]];
   UIImage* buttonImage =[[UIImage imageNamed:@"button.png"] stretchableImageWithLeftCapWidth:5.0 topCapHeight:0.0];
   [sendButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
 [super viewDidLoad];
 }

#pragma mark Send Message

-(NSString *)encodeString:(NSString *)string {
	NSString * encodedString = (NSString *)
    CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
	return encodedString;
}

- (NSString *)keyValuePost:(NSString *)key withValue:(NSString *)value {
    
	NSString *returnValue = [NSString stringWithFormat:@"&%@=%@", [self encodeString:key], [self encodeString:value]];
	return returnValue;
}

-(void)alertError {
	[alert dismissWithClickedButtonIndex:0 animated:YES];
	[alert release];
	alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Check username / password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	NSString *content = [[NSString alloc]  initWithBytes:[receivedData bytes] length:[receivedData length] encoding: NSUTF8StringEncoding];
	if ([content rangeOfString:@"ERROR"].location == NSNotFound) {
		[alert dismissWithClickedButtonIndex:0 animated:YES];
		[alert release];
		alert = [[UIAlertView alloc] initWithTitle:@"Sent" message:@"Message sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		
		[phoneNumber setText:@""];
		[messageBox setText:@""];
	} else {
		[self alertError];
	}
	
	[alert release];
	
    // release the connection, and the data object
    [connection release];
    [receivedData release];
	
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
	
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
	
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
} 

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
	[self alertError];
	[alert release];
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
	
    // inform the user
    NSLog(@"Connection failed! Error");
}


- (IBAction)sendMessage:(id)sender {
	[sendButton setEnabled:NO];
	[phoneNumber setEnabled:NO];
	[messageBox setEditable:NO];
    
	// verify inputs are valid
	BOOL valid = YES;
	
	// Load prefs
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *username = [defaults stringForKey:@"username_preference"];
	NSString *password = [defaults stringForKey:@"password_preference"];
    
	NSString *from = [defaults stringForKey:@"sent_preference"];
	NSString *url = @"http://www.smsglobal.com/http-api.php";
	
	// number to send to
	NSString *to = [phoneNumber text];
	
	// Validates phone number
	NSMutableString *strippedString = [NSMutableString stringWithCapacity:to.length];
	for (int i=0; i<[to length]; i++) {
        if (isdigit([to characterAtIndex:i])) {
			[strippedString appendFormat:@"%c",[to characterAtIndex:i]];
        }
	}
	
	if ([strippedString length] != 11) {
		valid = NO;
	}
	
	// message string
	NSString *text;
	if ([defaults boolForKey:@"single_sms_preference"] && ([[messageBox text] length] > 159)) {
		text = [[messageBox text] substringToIndex:159];
	} else {
		text = [messageBox text];
	}
	if ([text length] == 0) {
		valid = NO;
	}
	
	// reset fields
	if (valid == YES) {
		// http request
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
		
		//set HTTP Method
        [request setHTTPMethod:@"POST"];
        
        //Implement request_body for send request here username and password set into the body.
        NSMutableString *request_body = [NSMutableString stringWithCapacity:0];
		[request_body appendString:@"action=sendsms"];
		[request_body appendString:[self keyValuePost:@"user" withValue:username]];
		[request_body appendString:[self keyValuePost:@"password" withValue:password]];
		[request_body appendString:[self keyValuePost:@"to" withValue:to]];
		[request_body appendString:[self keyValuePost:@"from" withValue:from]];
		[request_body appendString:[self keyValuePost:@"text" withValue:text]];
        
        //set request body into HTTPBody.
        [request setHTTPBody:[request_body dataUsingEncoding:NSUTF8StringEncoding]];
		
        //set request url to the NSURLConnection
        NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		
		if (theConnection) {
			// Create the NSMutableData to hold the received data.
			// receivedData is an instance variable declared elsewhere.
			receivedData = [[NSMutableData data] retain];
			alert = [[UIAlertView alloc] initWithTitle:@"Sending" message:@"Please wait..." delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
		} else {
			alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Not enough internet." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert autorelease];
		}
	} else {
		alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Phone number invalid or message was empty." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert autorelease];
	}
    
	
	[alert show];
    
	[sendButton setEnabled:YES];
	[phoneNumber setEnabled:YES];
	[messageBox setEditable:YES];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark Address Book

- (IBAction)lookupContact:(id)sender {
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentModalViewController:picker animated:YES];
    [picker release];
}

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    
    // after getting what we want, we loop thru all the phone records till we get the mobile number.
    
    ABMultiValueRef multiPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    for(CFIndex i = 0; i < ABMultiValueGetCount(multiPhones); i++) {
        
        if(CFStringCompare(ABMultiValueCopyLabelAtIndex(multiPhones, i), kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
            CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
            CFRelease(multiPhones);
            NSString *phoneNo = (NSString *) phoneNumberRef;
            CFRelease(phoneNumberRef);
            self.phoneNumber.text = [NSString stringWithFormat:@"%@", phoneNo];
            [phoneNumber release];
        }
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier{
    return NO;
}


@end
