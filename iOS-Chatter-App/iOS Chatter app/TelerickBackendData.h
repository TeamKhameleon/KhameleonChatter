#import <Foundation/Foundation.h>
#import "ChatMessage.h"

@interface TelerickBackendData : NSObject

-(instancetype) init;

-(NSObject*)loginWithMail: (NSString*)email
         andPassword: (NSString*) password;

-(NSObject*)registerWithMail: (NSString*)email
         andPassword: (NSString*) password;

-(NSArray*)getRooms;

-(NSArray*)getMessagesInRoom: (NSObject*) room;

-(void)sendMessage: (ChatMessage*) message
            toRoom: (NSObject*) room;

@end
