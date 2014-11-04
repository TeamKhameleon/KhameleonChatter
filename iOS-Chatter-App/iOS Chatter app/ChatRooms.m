#import "ChatRooms.h"


@implementation ChatRooms


-(instancetype) initWithTitle: (NSString*)title andRoomDescr:(NSString*)descr{
    if (self = [super init]) {
        self.title = title;
        self.roomDescription = descr;
        self.messages = [[NSMutableArray alloc] init];
    }
    return self;
}
-(instancetype) initWithTitle: (NSString*)title roomDescr:(NSString*)descr andMessages: (NSMutableArray*)messages {
    if (self = [super init]) {
        self.title = title;
        self.roomDescription = descr;
        self.messages = messages;
    }
    return self;
}

@end
