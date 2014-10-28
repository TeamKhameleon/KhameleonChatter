#import "ChatMessage.h"

@implementation ChatMessage

-(instancetype) initWithTitle: (NSString*) title
                      message: (NSString*) message
                    andSender: (NSString*) sender {
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.sender = sender;
        self.date = [NSDate date];
    }
    return self;
}

-(void) setGeoLocation: (NSObject*) geolocation {
    self.geolocation = geolocation;
}

-(void) setPhoto: (NSObject*) photo {
    self.photo = photo;
}

@end
