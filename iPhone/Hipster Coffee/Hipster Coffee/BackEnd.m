#import "BackEnd.h"
#import "Venue.h"

@implementation BackEnd

- (id) exampleVenues
{
    NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ExampleVenueList" ofType:@"json"]];
    
    NSError * error = nil;
    id venuesJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"%@",error);
    return [Venue venuesFromJson:venuesJson];

}

- (void)processVenueListForLocation:(CLLocation *) location withBlock :(void (^)(NSArray *))block
{
    block([self exampleVenues]);
    NSLog(@"processVenueListForLocation");
}

- (void) processNearbyVenuesAtLocation:(CLLocation *) location withBlock:(void(^)(NSArray *venues)) block
{
    block([self exampleVenues]);
    NSLog(@"processNearbyVenuesAtLocation");

}

@end
