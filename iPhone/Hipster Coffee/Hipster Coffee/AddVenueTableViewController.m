#import "AddVenueTableViewController.h"
#import "BackEnd.h"
#import "VenueViewController.h"

@interface AddVenueTableViewController ()
@property (strong, nonatomic) NSArray *venues;
- (void) updateVenuesForCurrentLocation;
@end

@implementation AddVenueTableViewController

@synthesize venues=_venues;
@synthesize location=_location;

- (void)setLocation:(CLLocation *)location
{
    _location = location;
    [self updateVenuesForCurrentLocation];
}

- (void) setVenues:(NSArray *)venues
{
    _venues = venues;
    [self.tableView reloadData];
}

# pragma mark - ViewController lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setNeedsDisplay];
    [super viewWillAppear:animated];
}

# pragma mark - Action

- (void) updateVenuesForCurrentLocation
{
    if(self.location) {
        [[BackEnd sharedInstance] processNearbyVenuesAtLocation:self.location withBlock:^(NSArray *venues){
            self.venues = venues;
        }];
    }
}


# pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [[self.venues objectAtIndex:indexPath.row] title];
    cell.detailTextLabel.text = [[self.venues objectAtIndex:indexPath.row] streetAddress];
    return cell;
}

# pragma mark - Segue mathods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[VenueViewController class]]) {
        VenueViewController * venueViewController = ((VenueViewController *) segue.destinationViewController);
        venueViewController.venue = [self.venues objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        [venueViewController setEditModeEnabled:YES];
    }
}

@end
