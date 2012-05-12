#import "BackEnd.h"

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

- (void)uppdateVenue:(Venue *) venue;
{
    NSLog(@"updateVenue");
}

+ (BackEnd *)sharedInstance
{
    static BackEnd *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BackEnd alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

@end
