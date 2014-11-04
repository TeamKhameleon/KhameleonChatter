#import "LocalData.h"

@implementation LocalData


-(RoomList*) getRooms {
    return [[RoomList alloc] init];
}

-(Response*) updateRooms: (RoomList*) rooms {
    return [[Response alloc] initWithSuccess:YES andMessage:@"faked"];
}

@end
