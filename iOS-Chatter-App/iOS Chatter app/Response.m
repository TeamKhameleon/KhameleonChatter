#import "Response.h"

@implementation Response

-(instancetype) initWithSuccess: (BOOL) success
                     andMessage: (NSString*) message {
    if (self = [super init]) {
        self.success = success;
        self.message = message;
    }
    return self;
}

@end
