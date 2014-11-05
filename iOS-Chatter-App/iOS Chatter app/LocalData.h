#import <Foundation/Foundation.h>
#import "Response.h"

@interface LocalData : NSObject

// we will only store rooms. No messages will be stored. This allows us to have faster loading.

-(NSArray*) getRooms;
-(Response*) updateRooms: (NSArray*) rooms;

@end
