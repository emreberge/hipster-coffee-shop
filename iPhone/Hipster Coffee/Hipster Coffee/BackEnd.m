#import "BackEnd.h"
#import "AFJSONRequestOperation.h"
#import "UIImageView+AFNetworking.h"

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

- (void) processImagesForVenue:(Venue *) venue withBlock:(void(^)(NSArray *imageViews)) block
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?client_id=IREKXOE1D0AMI4MP1UHB1NFEIWVYC2XNL2XY5CDVK55JXRQ1&client_secret=LZUNTYJTDWZ23UHN5TVHOD4XQWRIPP2UZT4GFXGIG5TFO5IF&v=20120512", venue.foursquareID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        JSON = [[JSON objectForKey:@"response"] objectForKey:@"venue"];

        int imageCount = [[[JSON objectForKey:@"stats"] objectForKey:@"photoCount"] intValue];
        
        BOOL has2Index = [[[JSON objectForKey:@"photos"] objectForKey:@"groups"] count] == 2;
        int index = has2Index? 1:0; 
        id imageListJSON = [[[[JSON objectForKey:@"photos"] objectForKey:@"groups"] objectAtIndex:index] objectForKey:@"items"];
        NSLog(@"Venues: %@", JSON);

        
        NSMutableArray *imageViews = [[NSMutableArray alloc] initWithCapacity:imageCount];
        for(int i = 0; i < imageCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image3.jpg"]];
            [imageView setImageWithURL:[NSURL URLWithString:[[imageListJSON objectAtIndex:i] objectForKey:@"url"]]];
            [imageViews addObject:imageView];
        }
        block(imageViews);
        
    } failure:nil];
    [operation start];
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
