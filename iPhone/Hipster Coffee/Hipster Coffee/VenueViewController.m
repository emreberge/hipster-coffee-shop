#import "VenueViewController.h"

#define kPowerOutletChoices [NSArray arrayWithObjects:@"Many", @"A Few", @"None", nil]

@interface VenueViewController ()
- (void) saveChangesToVenue;
@end

@implementation VenueViewController

@synthesize editModeEnabled = _editModeEnabled;

@synthesize wifiSSID = _wifiSSID;
@synthesize wifiPassword = _wifiPassword;
@synthesize coffeePrice = _coffeePrice;
@synthesize powerOutlets = _powerOutlets;
@synthesize powerOutletsLabel = _powerOutletsLabel;

@synthesize venue = _venue;

#pragma mark -

- (Venue *)venue
{
    if (!_venue) {
        Venue *defaultVenue = [[Venue alloc] init];
        defaultVenue.wifiSSID = @"eduroam";
        defaultVenue.wifiPassword = @"secret";
        defaultVenue.coffeePrice = @"4711";
        defaultVenue.powerOutlets = @"A Few";
        self.venue = defaultVenue;
    }
    return _venue;
}
- (void)setVenue:(Venue *)venue
{
    _venue = venue;
    
    self.wifiSSID.text = venue.wifiSSID;
    self.wifiPassword.text = venue.wifiPassword;
    self.coffeePrice.text = venue.coffeePrice;

    self.powerOutletsLabel.text = venue.powerOutlets;
    self.powerOutlets.selectedSegmentIndex = [kPowerOutletChoices indexOfObject:venue.powerOutlets];
}


#pragma mark - Edit mode logic

- (void)updateControlsEditableState
{
    self.wifiSSID.enabled = self.editModeEnabled;
    self.wifiPassword.enabled = self.editModeEnabled;
    self.coffeePrice.enabled = self.editModeEnabled;
    [UIView animateWithDuration:0.3 animations:^{
        self.powerOutlets.alpha = self.editModeEnabled;
        self.powerOutletsLabel.alpha = !self.editModeEnabled;
    }];
    self.navigationItem.rightBarButtonItem = self.editModeEnabled? [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveChangesToVenue)]: nil;
}

- (void)setEditModeEnabled:(BOOL)editModeEnabled
{
    _editModeEnabled = editModeEnabled;
    [self updateControlsEditableState];
}


#pragma mark - UI Actions

- (IBAction)powerOutletsValueChanged:(id)sender {
    int selectedIndex = self.powerOutlets.selectedSegmentIndex;    
    self.powerOutletsLabel.text = [kPowerOutletChoices objectAtIndex:selectedIndex];
}

- (IBAction)saveChangesToVenue
{
    //[self.backEnd updateVenue:self.venue];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateControlsEditableState];
    self.editModeEnabled = YES;
}

- (void)viewDidUnload
{
    [self setWifiSSID:nil];
    [self setWifiPassword:nil];
    [self setCoffeePrice:nil];
    [self setPowerOutlets:nil];
    [self setPowerOutletsLabel:nil];
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.editModeEnabled) {
        [self.wifiSSID becomeFirstResponder];
    }
}


@end
