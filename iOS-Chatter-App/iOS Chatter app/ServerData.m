#import "TelerikBackendData.h"
#import <EverliveSDK/EverliveSDK.h>

@interface TelerikBackendData()

@property (nonatomic, strong) Everlive *everlive;
@property (nonatomic, strong) NSString *token;

@end

@implementation TelerikBackendData

TelerikBackendData *instance;

-(instancetype) init
{
    if (self = [super init]) {
        self.everlive = [Everlive sharedInstance];
        [self.everlive setAppKey:@"6OpNT5XmDQWF2t2h"];
    }
    return self;
}

+(instancetype) sharedInstance {
    if (!instance) {
        instance = [[TelerikBackendData alloc] init];
    }
    return instance;
}

+(NSString*) getNameFromEmail:(NSString*)email
{
    NSInteger index;
    for (index = 0; (index < email.length) && ([email characterAtIndex:index] != '@'); index++)
    {
    }
    NSString *name = [email substringToIndex: index];
    return name;
}

-(void)loginWithMail: (NSString*)email
            password: (NSString*) password
            andBlock: (void(^)(Response*r)) block
{
    NSString*name = [TelerikBackendData getNameFromEmail:email];
    
    __weak TelerikBackendData *weakself = self;
    [EVUser loginInWithUsername:name password:password block:^(EVUser *user, NSError *error) {
        NSString *message;
        if (error) {
            message= [NSString stringWithFormat:@"Could not login user. %@", [error localizedDescription]];
            block([[Response alloc]initWithSuccess:NO andMessage:message]);
            return;
        }
        message = [NSString stringWithFormat:@"User %@ is now logged in." , user.username];
        weakself.token = user.accessToken;
        block([[Response alloc]initWithSuccess:YES andMessage:message]);
    }];
}

-(void)registerWithMail: (NSString*)email
               password: (NSString*) password
               andBlock: (void(^)(Response*r)) block
{
    NSString*name = [TelerikBackendData getNameFromEmail:email];
    
    EVUser *newUser = [[EVUser alloc]init];
    [newUser setUsername:name];
    [newUser setPassword:password];
    [newUser setDisplayName:name];
    [newUser setEmail:email];
    [newUser signUp:^(EVUser *user, NSError *error) {
        NSString *message;
        if (error) {
            message= [NSString stringWithFormat:@"Could not register user. %@", [error localizedDescription]];
            block([[Response alloc]initWithSuccess:NO andMessage:message]);
            return;
        }
        message = [NSString stringWithFormat:@"User %@ was registered successfuly." , user.username];
        block([[Response alloc]initWithSuccess:YES andMessage:message]);
    }];
}

-(void) checkIfRoomsAreSame: (RoomList*) oldRooms
                  withBlock: (void(^)(Response*r, BOOL roomsAreSame, RoomList*updatedRooms)) block
{
    [self getRoomsWithBlock:^(Response *r, RoomList *rooms) {
        if (r.success) {
            NSInteger i, len = rooms.count;
            if (len != oldRooms.count) {
                block(r, NO, rooms);
                return;
            }
            for (i=0; i<len; i++) {
                ChatRooms *r1 = oldRooms[i];
                ChatRooms *r2 = rooms[i];
                if (r1.roomId != r2.roomId ||
                    r1.roomDescription != r2.roomDescription ||
                    r1.title != r2.title) {
                    block(r, NO, rooms);
                    return;
                }
            }
            block(r, YES, oldRooms);
            return;
        }
    }];
}

-(void) getRoomsWithBlock: (void(^)(Response*r, RoomList*rooms)) block
{
    EVDataStore *dataStore = [EVDataStore sharedInstance];
    [dataStore fetchAll:[ChatRooms class] block:^(NSArray *result, NSError *error) {
        Response*r;
        if (error) {
            r= [[Response alloc] initWithSuccess:NO andMessage: [error localizedDescription]];
        }
        else {
            r = [[Response alloc]initWithSuccess:YES andMessage:@"Rooms were successfuly accuired."];
        }
        RoomList* rooms = [[RoomList alloc] initWithArray:result];
        block(r, rooms);
    }];
}

-(void)getUpdatedRoom: (ChatRooms*) room
            withBlock: (void(^)(Response*r, ChatRooms*room)) block
{
    EVDataStore *dataStore = [EVDataStore sharedInstance];
    [dataStore fetch:[ChatRooms class] uniqueId:room.roomId block:^(NSArray *result, NSError *error) {
        Response*r;
        if (error) {
            r= [[Response alloc] initWithSuccess:NO andMessage: [error localizedDescription]];
        }
        else {
            r = [[Response alloc]initWithSuccess:YES andMessage:@"Room were successfuly updated."];
            ChatRooms *nRoom = [result objectAtIndex:0];
            NSInteger len= MIN(500, nRoom.messages.count);
            NSRange range = NSMakeRange(nRoom.messages.count - len, len);
            room.messages = [NSMutableArray arrayWithArray:[nRoom.messages subarrayWithRange:range]];
        }
        
        block(r, room);
    }];
}

-(void)sendMessage: (ChatMessage*) message
            toRoom: (ChatRooms*) room
         withBlock: (void(^)(Response*r)) block
{
    [room.messages addObject: message];
    
    EVDataStore *dataStore = [EVDataStore sharedInstance];
    [dataStore update:room block:^(BOOL success, NSError *error) {
        Response*r;
        if (error) {
            r= [[Response alloc] initWithSuccess:NO andMessage: [error localizedDescription]];
        }
        else {
            r = [[Response alloc]initWithSuccess:YES andMessage:@"Message was sent successfuly."];
        }
        
        block(r);
    }];
}

@end
