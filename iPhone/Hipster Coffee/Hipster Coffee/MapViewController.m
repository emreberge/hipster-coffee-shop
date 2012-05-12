
#import "MapViewController.h"
#import "BackEnd.h"
#import "Venue.h"
#import "AddVenueTableViewController.h"

#define kLocationTrackingDinstance 100

@interface MapViewController ()
@property (strong, nonatomic) CLLocationManager * locationManager;
@property (strong, nonatomic) BackEnd *backEnd;
- (void) initLocationManager;
- (void) replaceMapAnnotationsWith:(NSArray *) mapAnnotations;
@end

@implementation MapViewController
@synthesize mapView=_mapView;
@synthesize locationManager=_locationManager;
@synthesize backEnd=_backEnd;

- (CLLocationManager *)locationManager
{
    if(!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (BackEnd *)backEnd
{
    if(!_backEnd) {
        _backEnd = [[BackEnd alloc] init];
    }
    return _backEnd;
}

# pragma mark - View Controller lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self initLocationManager];
	// Do any additional setup after loading the view.
}

- (void) initLocationManager
{
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kLocationTrackingDinstance;
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setLocationManager:nil];
    [self setBackEnd:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mapView.showsUserLocation = NO;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - Actions

- (IBAction) updateVenuesAndAnimateToUserLocation
{
    [self updateVenues];
    [self animateToUserLocation];
}

- (IBAction)updateVenues
{
    
    [self.backEnd processVenueListForLocation:self.locationManager.location withBlock:^(NSArray *venues){
        [self replaceMapAnnotationsWith:venues];
    }];
}

- (IBAction)animateToUserLocation
{
    [self.mapView setRegion:MKCoordinateRegionMake(self.locationManager.location.coordinate, MKCoordinateSpanMake(0.01,0.01)) animated:YES];
}

- (IBAction) showDetailsOfSelectedVenue
{
    [self performSegueWithIdentifier:@"ShowVenueView" sender:self];
}

- (void) replaceMapAnnotationsWith:(NSArray *) mapAnnotations
{
    for (id annotation in self.mapView.annotations) {
        if([annotation isKindOfClass:[Venue class]]) {
            [self.mapView removeAnnotation:annotation];
        }
    }
    [self.mapView addAnnotations:mapAnnotations];
}

# pragma mark - Segue mathods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[AddVenueTableViewController class]]) {
        ((AddVenueTableViewController *) segue.destinationViewController).location = self.locationManager.location;
    }
}

# pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *) mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinAnnotation = nil;
    if(annotation != mapView.userLocation) 
    {
        static NSString *defaultPinID = @"Pin";
        pinAnnotation = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinAnnotation == nil ) {
            pinAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
            pinAnnotation.canShowCallout = YES;
            pinAnnotation.pinColor = MKPinAnnotationColorGreen;
            UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinAnnotation.rightCalloutAccessoryView = infoButton;
            [infoButton addTarget:self action:@selector(showDetailsOfSelectedVenue) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return pinAnnotation;
}

# pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self updateVenuesAndAnimateToUserLocation];
}

@end
