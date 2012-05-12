//
//  VenueViewController.h
//  Hipster Coffee
//
//  Created by Emre Ergenekon on 5/12/12.
//  Copyright (c) 2012 Splunk, Bontouch AB, Codely HB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *wifiSSID;
@property (weak, nonatomic) IBOutlet UITextField *wifiPassword;
@property (weak, nonatomic) IBOutlet UITextField *coffeePrice;
@property (weak, nonatomic) IBOutlet UISegmentedControl *powerOutlets;

@end
