//
//  MSMainViewController.h
//  MaxSMS
//
//  Created by Maxwell Swadling on 26/10/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "MSFlipsideViewController.h"

@interface MSMainViewController : UIViewController <MSFlipsideViewControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

- (IBAction)showInfo:(id)sender;

@end
