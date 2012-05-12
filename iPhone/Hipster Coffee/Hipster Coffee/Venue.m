#import "Venue.h"

@interface Venue()
- (NSString *) valueForKey:(NSString *)key or:(NSString *) defaultValue;
@end


@implementation Venue

@synthesize venueJson=_venueJson;

- (id)init {
    return [self initWithJSON:[NSMutableDictionary dictionary]];
}

- (id)initWithJSON:(id)venueJson
{
    if(self = [super init]) {
        self.venueJson = venueJson;
    }
    return self;
}

- (NSString *)wifiSSID
{
    return [self valueForKey:@"wifi_ssid" or:@""];
}
- (NSString *)wifiPassword
{
    return [self valueForKey:@"wifi_password" or:@""];
}
- (NSString *)coffeePrice
{
    return [self valueForKey:@"coffee_price" or:@""];
}
- (NSString *)powerOutlets
{
    return [self valueForKey:@"power_outlets" or:@"None"];
}

- (NSString *) valueForKey:(NSString *)key or:(NSString *) defaultValue
{
    NSString *value = [self.venueJson objectForKey:key];
    if (!value) {
        value = @"";
    }
    return value;
}

- (void)setWifiSSID:(NSString *)wifiSSID
{
    [self.venueJson setObject:wifiSSID forKey:@"wifi_ssid"];
}
- (void)setWifiPassword:(NSString *)wifiPassword
{
    [self.venueJson setObject:wifiPassword forKey:@"wifi_password"];
}
- (void)setCoffeePrice:(NSString *)coffeePrice
{
    [self.venueJson setObject:coffeePrice forKey:@"coffee_price"];
}
- (void)setPowerOutlets:(NSString *)powerOutlets
{
    [self.venueJson setObject:powerOutlets forKey:@"power_outlets"];
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
