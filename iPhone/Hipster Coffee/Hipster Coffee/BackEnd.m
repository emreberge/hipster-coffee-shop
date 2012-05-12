#import "BackEnd.h"
#import "Venue.h"

@implementation BackEnd

- (void)processVenueListForLocation:(CLLocation *) location withBlock :(void (^)(NSArray *))block
{
    NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ExampleVenueList" ofType:@"json"]];
    
    NSError * error = nil;
    id venuesJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    block([Venue venuesFromJson:venuesJson]);
    NSLog(@"%@",error);
    NSLog(@"processVenueListForLocation");
}

@end
