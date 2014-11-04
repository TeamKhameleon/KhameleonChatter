#import "GeoLocationHandler.h"

@interface GeoLocationHandler() <CLLocationManagerDelegate>
@end

@implementation GeoLocationHandler{
    CLLocationManager* locationManager;
    void (^_block)(CLLocation *);
}

-(instancetype)init{
    if(self = [super init]){
        locationManager = [[CLLocationManager alloc] init];
        [self setupLocationManager];
    }
    return self;
}

-(void)getLocationWithBlock:(void (^)(CLLocation *location))block{
    _block = block;
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
}

-(void) setupLocationManager{
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters ;
    locationManager.delegate = self;
}

-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations{
    CLLocation* location = [locations lastObject];
    if(_block){
        _block(location);
        _block = nil;
    }
    [locationManager stopUpdatingLocation];
}


-(void) getLocationString: (CLLocation*) location withBlock: (void(^)(NSString*locationString)) block {
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSString* locationName = [NSString stringWithFormat:@"%@, %@", [placemark locality], [placemark country] ];
        block(locationName);
    }];
}

@end
