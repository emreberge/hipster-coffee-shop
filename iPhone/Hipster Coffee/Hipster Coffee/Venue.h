#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
/*
 {
    venues: [
        {
            latitude: 34.2341
            longitude: 43.234
            name: "Hipster Coffee Shop"
        },
        {
            latitude: 34.2341
            longitude: 43.234
            name: "Hipster Coffee Shop"
        },
    ]
 }
 */
@interface Venue : NSObject <MKAnnotation>

// Designated Initializer
- (id) initWithJSON:(id) venueJson;

+ (NSArray *) venuesFromJson:(id) json;
@end
