#import "VenueViewController.h"

#define kPowerOutletChoices [NSArray arrayWithObjects:@"Many", @"A Few", @"None", nil]

@interface VenueViewController ()
@end

@implementation VenueViewController

@synthesize editModeEnabled = _editModeEnabled;

@synthesize toggleEditModeButton = _toggleEditModeButton;
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
        self.venue = [[Venue alloc] init];
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

- (void)setDefaultState
{
    self.editModeEnabled = NO;
    
    Venue *v = [[Venue alloc] init];
    v.wifiSSID = @"eduroam";
    v.wifiPassword = @"secret";
    v.coffeePrice = @"4711";
    v.powerOutlets = @"A Few";
    self.venue = v;
}

- (void)updateControlsEditableState
{
    if (self.editModeEnabled) {
        self.toggleEditModeButton.title = @"Save";
    } else {
        self.toggleEditModeButton.title = @"Edit";
    }
    
    self.wifiSSID.enabled = self.editModeEnabled;
    self.wifiPassword.enabled = self.editModeEnabled;
    self.coffeePrice.enabled = self.editModeEnabled;
    [UIView animateWithDuration:0.3 animations:^{
        self.powerOutlets.alpha = self.editModeEnabled;
        self.powerOutletsLabel.alpha = !self.editModeEnabled;
    }];
}

- (void)setEditModeEnabled:(BOOL)editModeEnabled
{
    _editModeEnabled = editModeEnabled;
    [self updateControlsEditableState];
}

- (void)toggleEditMode
{    
    self.editModeEnabled = !self.editModeEnabled;
    [self.wifiSSID becomeFirstResponder];
}


#pragma mark - UI Actions

- (IBAction)toggleEditModeButtonPressed:(id)sender {
    [self toggleEditMode];
}

- (IBAction)powerOutletsValueChanged:(id)sender {
    int selectedIndex = self.powerOutlets.selectedSegmentIndex;    
    self.powerOutletsLabel.text = [kPowerOutletChoices objectAtIndex:selectedIndex];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDefaultState];
}

- (void)viewDidUnload
{
    [self setWifiSSID:nil];
    [self setWifiPassword:nil];
    [self setCoffeePrice:nil];
    [self setPowerOutlets:nil];
    [self setPowerOutletsLabel:nil];
    [self setToggleEditModeButton:nil];
    [super viewDidUnload];
}


@end
