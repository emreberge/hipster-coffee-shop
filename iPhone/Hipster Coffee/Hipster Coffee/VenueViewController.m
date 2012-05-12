#import "VenueViewController.h"
#import "BackEnd.h"

#define kPowerOutletChoices [NSArray arrayWithObjects:@"Many", @"A Few", @"None", nil]

@interface VenueViewController ()
- (IBAction) saveChangesToVenue;
- (IBAction) updateViewForCurrentVenue;
@end

@implementation VenueViewController

@synthesize editModeEnabled = _editModeEnabled;

@synthesize wifiSSID = _wifiSSID;
@synthesize wifiPassword = _wifiPassword;
@synthesize coffeePrice = _coffeePrice;
@synthesize powerOutlets = _powerOutlets;
@synthesize powerOutletsLabel = _powerOutletsLabel;
@synthesize imageScrollView = _imageScrollView;
@synthesize imageViews=_imageViews;

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
    [self updateViewForCurrentVenue];
}

- (void)setImageViews:(NSArray *)imageViews
{
    _imageViews=imageViews;
    NSLog(@"count: %i", [imageViews count]);
    [self layoutScrollImages:imageViews];
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
    [[BackEnd sharedInstance] uppdateVenue:self.venue];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)updateViewForCurrentVenue
{
    self.wifiSSID.text = self.venue.wifiSSID;
    self.wifiPassword.text = self.venue.wifiPassword;
    self.coffeePrice.text = self.venue.coffeePrice;
    self.powerOutletsLabel.text = self.venue.powerOutlets;
    self.powerOutlets.selectedSegmentIndex = [kPowerOutletChoices indexOfObject:self.venue.powerOutlets];
    self.title = self.venue.title;
    [[BackEnd sharedInstance] processImagesForVenue:self.venue withBlock:^(NSArray *imageViews){
        self.imageViews = imageViews;
    }];
}

#pragma mark - Image update

#define kScrollObjWidth 320.0
#define kScrollObjHeight 240.0

- (void) layoutScrollImages:(NSArray *) images
{
    // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
    
    for (UIImageView *view in self.imageScrollView.subviews)
	{
		if ([view isKindOfClass:[UIImageView class]])
		{
            [view removeFromSuperview];
		}
	}

    
    for (int i = 0; i < [images count]; i++) {
        UIImageView *imageView = [images objectAtIndex:i];
		CGRect rect = imageView.frame;
		rect.size.height = kScrollObjHeight;
		rect.size.width = kScrollObjWidth;
		imageView.frame = rect;
        imageView.tag = i+1;
        imageView.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeCenter;
        imageView.clipsToBounds = YES;
        [self.imageScrollView addSubview:imageView];
    }
    
    
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (UIImageView *view in self.imageScrollView.subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (kScrollObjWidth);
		}
	}
	
	// set the content size so it can be scrollable
    self.imageScrollView.contentSize = CGSizeMake(([images count] * kScrollObjWidth), kScrollObjHeight);

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initScrollView];
    [self updateControlsEditableState];
    [self updateViewForCurrentVenue];
    [self layoutScrollImages:self.imageViews];
}

- (void) initScrollView
{
    self.imageScrollView.backgroundColor = UIColor.blackColor;
	self.imageScrollView.canCancelContentTouches= NO;
	self.imageScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	self.imageScrollView.clipsToBounds = YES;
	self.imageScrollView.scrollEnabled = YES;
	self.imageScrollView.pagingEnabled = YES;
}

- (void)viewDidUnload
{
    [self setWifiSSID:nil];
    [self setWifiPassword:nil];
    [self setCoffeePrice:nil];
    [self setPowerOutlets:nil];
    [self setPowerOutletsLabel:nil];
    [self setImageScrollView:nil];
    [self setImageViews:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"headerbg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setNeedsDisplay];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.editModeEnabled) {
        [self.wifiSSID becomeFirstResponder];
    }
}


@end
