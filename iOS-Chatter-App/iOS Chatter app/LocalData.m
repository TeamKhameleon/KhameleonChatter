#import "LocalData.h"

@implementation LocalData


-(NSArray*) getRooms {
    return [[NSArray alloc] init];
}

-(Response*) updateRooms: (NSArray*) rooms {
    return [[Response alloc] initWithSuccess:YES andMessage:@"faked"];
}

@end
