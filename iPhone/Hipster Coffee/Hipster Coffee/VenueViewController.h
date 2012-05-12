#import <UIKit/UIKit.h>

@interface VenueViewController : UITableViewController

#pragma mark - State
@property (nonatomic) BOOL editModeEnabled;

#pragma mark - UI components
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *wifiSSID;
@property (weak, nonatomic) IBOutlet UITextField *wifiPassword;
@property (weak, nonatomic) IBOutlet UITextField *coffeePrice;
@property (weak, nonatomic) IBOutlet UISegmentedControl *powerOutlets;
@property (weak, nonatomic) IBOutlet UILabel *powerOutletsLabel;

@end
