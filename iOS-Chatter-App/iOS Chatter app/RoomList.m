#import "RoomList.h"
#import "ChatRooms.h"

@implementation RoomList

-(void)addObject:(id)anObject {
    if ([anObject isKindOfClass: [ChatRooms class]]) {
        [super addObject:anObject];
    }
}

@end
