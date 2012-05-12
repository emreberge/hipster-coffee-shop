#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"
#import "Venue.h"

@interface BackEnd : NSObject

- (void) processVenueListForLocation:(CLLocation *) location withBlock:(void (^)(NSArray *venues)) block;
- (void) processNearbyVenuesAtLocation:(CLLocation *) location withBlock:(void(^)(NSArray *venues)) block;
- (void)uppdateVenue:(Venue *) venue;
+ (BackEnd *)sharedInstance;
@end
