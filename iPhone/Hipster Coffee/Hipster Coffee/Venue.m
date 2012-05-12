#import "Venue.h"

@interface Venue()
@property(nonatomic) id venueJson;
@end


@implementation Venue

@synthesize venueJson=_venueJson;

- (id)initWithJSON:(id)venueJson
{
    if(self = [super init]) {
        self.venueJson = venueJson;
    }
    return self;
}

# pragma mark - MKAnnotation properties

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coord;
    coord.latitude =  [[self.venueJson objectForKey:@"latitude"] doubleValue];
    coord.longitude = [[self.venueJson objectForKey:@"longitude"] doubleValue];
    return coord; 
}

- (NSString *)title
{
    return [self.venueJson objectForKey:@"name"];
}

# pragma mark Class Methods

+(NSArray *)venuesFromJson:(id) json
{
    id venuesJson = [json objectForKey:@"venues"];
    NSMutableArray *venues = [NSMutableArray arrayWithCapacity:[venuesJson count]];
    for (id venueJSON in venuesJson) {
        [venues addObject:[[Venue alloc] initWithJSON:venueJSON]];
    }
    return [NSArray arrayWithArray:venues]; // Create non-mutable array
}

@end
