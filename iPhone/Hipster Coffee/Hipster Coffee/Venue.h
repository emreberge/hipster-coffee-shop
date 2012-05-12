#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/*
 * See ExampleVenueList.json for example
 */
@interface Venue : NSObject <MKAnnotation>

// Designated Initializer
- (id) initWithJSON:(id) venueJson;

+ (NSArray *) venuesFromJson:(id) json;

@property(nonatomic, strong) id venueJson;

@property (nonatomic, strong) NSString *foursquareID;
@property (nonatomic, strong) NSString *wifiSSID;
@property (nonatomic, strong) NSString *wifiPassword;
@property (nonatomic, strong) NSString *coffeePrice;
@property (nonatomic, strong) NSString *powerOutlets;

@end
