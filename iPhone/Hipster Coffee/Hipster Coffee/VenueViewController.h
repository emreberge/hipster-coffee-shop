#import <UIKit/UIKit.h>
#import "Venue.h"

@interface VenueViewController : UITableViewController

@property (strong, nonatomic) Venue *venue;

#pragma mark - State
@property (nonatomic) BOOL editModeEnabled;


#pragma mark - UI components
@property (weak, nonatomic) IBOutlet UITextField *wifiSSID;
@property (weak, nonatomic) IBOutlet UITextField *wifiPassword;
@property (weak, nonatomic) IBOutlet UITextField *coffeePrice;
@property (weak, nonatomic) IBOutlet UISegmentedControl *powerOutlets;
@property (weak, nonatomic) IBOutlet UILabel *powerOutletsLabel;


@end
