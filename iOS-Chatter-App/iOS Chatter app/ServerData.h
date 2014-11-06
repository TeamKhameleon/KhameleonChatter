#import <Foundation/Foundation.h>
#import "ChatMessage.h"
#import "Response.h"
#import "ChatRooms.h"

@interface ServerData : NSObject

-(instancetype) init;

+(NSString*) getUsername;
+(instancetype) sharedInstance;

-(void)loginWithMail: (NSString*)email
      password: (NSString*) password
      andBlock: (void(^)(Response*r)) block;

-(void)registerWithMail: (NSString*)email
         password: (NSString*) password
         andBlock: (void(^)(Response*r)) block;

-(void) getRoomsWithBlock: (void(^)(Response*r, NSArray*rooms)) block;

-(void)getUpdatedRoom: (ChatRooms*) room
            withBlock: (void(^)(Response*r, ChatRooms*room)) block;

-(void)sendMessage: (ChatMessage*) message
            toRoom: (ChatRooms*) room
         withBlock: (void(^)(Response*r)) block;

@end
