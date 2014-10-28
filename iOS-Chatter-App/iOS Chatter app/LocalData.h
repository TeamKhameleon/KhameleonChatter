#import <Foundation/Foundation.h>
#import "RoomList.h"
#import "Response.h"

@interface LocalData : NSObject

// we will only store rooms. No messages will be stored. This allows us to have faster loading.

-(RoomList*) getRooms;
-(Response*) updateRooms;

@end
