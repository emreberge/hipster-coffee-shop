#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

@interface BackEnd : NSObject

- (void) processVenueListForLocation:(CLLocation *) location withBlock:(void (^)(NSArray *venues)) block;

@end
