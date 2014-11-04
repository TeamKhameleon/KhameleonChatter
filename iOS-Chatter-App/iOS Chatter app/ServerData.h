#import <Foundation/Foundation.h>
#import "ChatMessage.h"
#import "Response.h"
#import "RoomList.h"
#import "ChatRooms.h"

@interface ServerData : NSObject

-(instancetype) init;

+(instancetype) sharedInstance;

-(void)loginWithMail: (NSString*)email
      password: (NSString*) password
      andBlock: (void(^)(Response*r)) block;

-(void)registerWithMail: (NSString*)email
         password: (NSString*) password
         andBlock: (void(^)(Response*r)) block;

-(void) checkIfRoomsAreSame: (RoomList*) oldRooms
                   withBlock: (void(^)(Response*r,BOOL roomsAreSame, RoomList*updatedRooms)) block;

-(void) getRoomsWithBlock: (void(^)(Response*r, RoomList*rooms)) block;

-(void)getUpdatedRoom: (ChatRooms*) room
            withBlock: (void(^)(Response*r, ChatRooms*room)) block;

-(void)sendMessage: (ChatMessage*) message
            toRoom: (ChatRooms*) room
         withBlock: (void(^)(Response*r)) block;

@end
