
#import "MapViewController.h"
#import "BackEnd.h"
#import "Venue.h"

#define kLocationTrackingDinstance 100

@interface MapViewController ()
@property (nonatomic) CLLocationManager * locationManager;
@property (nonatomic) BackEnd *backEnd;
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

- (IBAction)updateVenues
{
    
    [self.backEnd processVenueListForLocation:self.locationManager.location withBlock:^(NSArray *venues){
        [self replaceMapAnnotationsWith:venues];
    }];
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

# pragma mark - MKMapViewDelegate

# pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self updateVenues];
}

@end
