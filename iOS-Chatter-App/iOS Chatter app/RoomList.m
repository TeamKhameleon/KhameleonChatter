#import "RoomList.h"
#import "ChatRooms.h"

@implementation RoomList

-(void)addObject:(id)anObject {
    if ([anObject isKindOfClass: [ChatRooms class]]) {
        [super addObject:anObject];
    }
}

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    if (to != from) {
        id obj = [self objectAtIndex:from];
        [obj retain];
        [self removeObjectAtIndex:from];
        if (to >= [self count]) {
            [self addObject:obj];
        } else {
            [self insertObject:obj atIndex:to];
        }
        [obj release];
    }
}

@end
