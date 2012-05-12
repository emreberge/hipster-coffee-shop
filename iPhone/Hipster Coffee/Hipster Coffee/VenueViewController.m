#import "VenueViewController.h"

@interface VenueViewController ()

@end

@implementation VenueViewController

@synthesize editModeEnabled = _editModeEnabled;

@synthesize saveButton = _saveButton;
@synthesize wifiSSID = _wifiSSID;
@synthesize wifiPassword = _wifiPassword;
@synthesize coffeePrice = _coffeePrice;
@synthesize powerOutlets = _powerOutlets;
@synthesize powerOutletsLabel = _powerOutletsLabel;

#pragma mark - Toggling edit mode

- (void)setDefaultState
{
    self.editModeEnabled = NO;
}

- (void)updateControlsEditableState
{
    self.wifiSSID.enabled = self.editModeEnabled;
    self.wifiPassword.enabled = self.editModeEnabled;
    self.coffeePrice.enabled = self.editModeEnabled;
    
    self.powerOutlets.hidden = !self.editModeEnabled;
    self.powerOutletsLabel.hidden = self.editModeEnabled;
}

- (void)setEditModeEnabled:(BOOL)editModeEnabled
{
    _editModeEnabled = editModeEnabled;
    [self updateControlsEditableState];
}


#pragma mark - Actions

- (IBAction)saveButtonPressed:(id)sender {
    self.editModeEnabled = !self.editModeEnabled;
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
    [self setSaveButton:nil];
    [self setPowerOutletsLabel:nil];
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
