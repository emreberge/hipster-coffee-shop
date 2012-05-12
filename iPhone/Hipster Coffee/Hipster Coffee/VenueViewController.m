#import "VenueViewController.h"

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


#pragma mark - Edit mode logic

- (void)setDefaultState
{
    self.editModeEnabled = NO;
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
    //self.powerOutletsLabel.text = self.powerOutlets.
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


#pragma mark - Table view data source

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
