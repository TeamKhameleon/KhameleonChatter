#import <Foundation/Foundation.h>
#import "ChatMessage.h"
#import "Response.h"
#import "RoomList.h"
#import "ChatRoom.h"

@interface TelerikBackendData : NSObject

-(instancetype) init;

-(Response*)loginWithMail: (NSString*)email
         andPassword: (NSString*) password;

-(Response*)registerWithMail: (NSString*)email
         andPassword: (NSString*) password;

-(BOOL) checkIfRoomsAreSame: (RoomList*) rooms;
-(RoomList*) getRooms;

-(ChatRoom*)updateMessagesInRoom: (ChatRoom*) room;

-(Response*)sendMessage: (ChatMessage*) message
                       toRoom: (ChatRoom*) room;

@end
