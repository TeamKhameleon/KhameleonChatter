#import "ChatMessage.h"

@implementation ChatMessage

-(instancetype) initFromDictionarishObject: (PFObject*) message {
    if (self = [super init]) {
        self.title = message[@"title"];
        self.message = message[@"message"];
        self.sender = message[@"sender"];
        self.date = message[@"date"];
        self.photo = message[@"photo"];
        self.location = message[@"location"];
    }
    return self;
}

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

-(void) setGeoLocation: (NSString*) location {
    self.location = location;
}

-(void) setPhoto: (NSObject*) photo {
    self.photo = photo;
}

@end
