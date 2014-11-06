#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ChatMessage : NSObject

+(NSString*)dateToString: (NSDate*)date;
-(instancetype) initFromDictionary: (NSDictionary*) message;

-(instancetype) initWithTitle: (NSString*) title
                      message: (NSString*) message
                    andSender: (NSString*) sender;

- (void) setGeoLocation: (NSObject*) geolocation;
- (void) setPhotoWithObject: (UIImage*) photo;
- (UIImage*) getPhoto;

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSString* sender;

@property (nonatomic, strong) NSString* photo;
@property (nonatomic, strong) NSString* location;

@property (nonatomic, strong) NSDate* date;

@end
