#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GeoLocationHandler : NSObject

-(void)getLocationWithBlock:(void(^)(CLLocation*location))block;
-(void) getLocationString: (CLLocation*) location withBlock: (void(^)(NSString*locationString)) block;

@end
