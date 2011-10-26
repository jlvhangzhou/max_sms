//
//  MSFlipsideViewController.h
//  MaxSMS
//
//  Created by Maxwell Swadling on 26/10/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSFlipsideViewController;

@protocol MSFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(MSFlipsideViewController *)controller;
@end

@interface MSFlipsideViewController : UIViewController

@property (assign, nonatomic) IBOutlet id <MSFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
