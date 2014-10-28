#import <Foundation/Foundation.h>

@interface ChatMessage : NSObject

-(instancetype) initWithTitle: (NSString*) title
                      message: (NSString*) message
                    andSender: (NSString*) sender;

-(void) setGeoLocation: (NSObject*) geolocation;
-(void) setPhoto: (NSObject*) photo;

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSString* sender;

@property (nonatomic, strong) NSObject* photo;
@property (nonatomic, strong) NSObject* geolocation;

@property (nonatomic, strong) NSDate* date;

@end
