#import <UIKit/UIKit.h>

@interface VenueViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *wifiSSID;
@property (weak, nonatomic) IBOutlet UITextField *wifiPassword;
@property (weak, nonatomic) IBOutlet UITextField *coffeePrice;
@property (weak, nonatomic) IBOutlet UISegmentedControl *powerOutlets;

@end
