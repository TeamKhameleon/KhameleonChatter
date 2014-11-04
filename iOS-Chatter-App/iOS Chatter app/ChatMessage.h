#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ChatMessage : NSObject

-(instancetype) initFromDictionarishObject: (PFObject*) message;

-(instancetype) initWithTitle: (NSString*) title
                      message: (NSString*) message
                    andSender: (NSString*) sender;

-(void) setGeoLocation: (NSObject*) geolocation;
-(void) setPhoto: (NSObject*) photo;

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSString* sender;

@property (nonatomic, strong) UIImage* photo;
@property (nonatomic, strong) NSString* location;

@property (nonatomic, strong) NSDate* date;

@end
