#import "ServerData.h"
#import "ChatRooms.h"
#import <Parse/Parse.h>

@interface ServerData()

@property (nonatomic, strong) NSString *token;

@end

@implementation ServerData

NSString* usersTableName = @"Users";
NSString* usersEmailFieldName = @"email";
NSString* usersNameFieldName = @"name";
NSString* usersPasswordFieldName = @"password";

NSString* roomsTableName = @"ChatRooms";
NSString* roomTitleFieldName = @"title";
NSString* roomDescrFieldName = @"roomDescription";
NSString* roomMessagesFieldName = @"messages";

ServerData *instance;

-(instancetype) init
{
    self = [super init];
    return self;
}

+(instancetype) sharedInstance {
    if (!instance) {
        instance = [[ServerData alloc] init];
    }
    return instance;
}

+(NSString*) getNameFromEmail:(NSString*)email
{
    NSInteger index;
    for (index = 0; (index < email.length) && ([email characterAtIndex:index] != '@'); index++)
    { }
    NSString *name = [email substringToIndex: index];
    return name;
}

-(void)loginWithMail: (NSString*)email
            password: (NSString*) password
            andBlock: (void(^)(Response*r)) block
{
    NSString*name = [ServerData getNameFromEmail:email];
    PFQuery *query = [PFQuery queryWithClassName: usersTableName];
    [query whereKey:usersEmailFieldName equalTo:email];
    [query whereKey:usersPasswordFieldName equalTo: password];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSString* message = [NSString stringWithFormat:@"User %@ is now logged in" , name];
            block([[Response alloc]initWithSuccess:YES andMessage:message]);
        }
        else {
            block([[Response alloc]initWithSuccess:NO andMessage:@"Could not login user."]);
        }
    }];
    
}

-(void)registerWithMail: (NSString*) email
               password: (NSString*) password
               andBlock: (void(^)(Response*r)) block
{
    
    NSString*name = [ServerData getNameFromEmail:email];
    
    PFObject *testObject = [PFObject objectWithClassName: usersTableName];
    testObject[usersNameFieldName] = name;
    testObject[usersEmailFieldName] = email;
    testObject[usersPasswordFieldName] = password;
    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSString* message = [NSString stringWithFormat:@"User %@ is now registered" , name];
            block([[Response alloc]initWithSuccess:YES andMessage:message]);
        }
        else {
            block([[Response alloc]initWithSuccess:NO andMessage:@"Could not register user."]);
        }
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
                if (r1.roomDescription != r2.roomDescription ||
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
    PFQuery *query = [PFQuery queryWithClassName: roomsTableName];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {        Response*r;
        if (error) {
            r= [[Response alloc] initWithSuccess:NO andMessage: [error localizedDescription]];
        }
        else {
            r = [[Response alloc]initWithSuccess:YES andMessage:@"Rooms were successfuly accuired."];
        }
        RoomList* rooms = [[RoomList alloc] init];
        
        for (PFObject *object in objects) {
            ChatRooms*room = [[ChatRooms alloc] initWithTitle: object[roomTitleFieldName]
                                                    andRoomDescr: object[roomDescrFieldName]];
            [rooms addObject: room];
        }
        block(r, rooms);
    }];
}

-(void)getUpdatedRoom: (ChatRooms*) room
            withBlock: (void(^)(Response*r, ChatRooms*room)) block
{
    
    PFQuery *query = [PFQuery queryWithClassName: roomsTableName];
    [query whereKey:roomTitleFieldName equalTo:room.title];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        Response*r;
        if (error) {
            r= [[Response alloc] initWithSuccess:NO andMessage: [error localizedDescription]];
        }
        else {
            r = [[Response alloc]initWithSuccess:YES andMessage:@"Room were successfuly updated."];
            PFObject *nRoom = [objects objectAtIndex:0];
            NSMutableArray* messages = [[NSMutableArray alloc] init];
            
            for (PFObject*msg in nRoom[roomMessagesFieldName]) {
                ChatMessage *message = [[ChatMessage alloc] initFromDictionarishObject:msg];
                [messages addObject:message];
            }
            
            NSInteger len= MIN(500, messages.count);
            NSRange range = NSMakeRange(messages.count - len, len);
            room.messages = [NSMutableArray arrayWithArray:[messages subarrayWithRange:range]];
        }
        
        block(r, room);
    }];
}

-(void)sendMessage: (ChatMessage*) message
            toRoom: (ChatRooms*) room
         withBlock: (void(^)(Response*r)) block
{
    [room.messages addObject: message];
    
    PFQuery *query = [PFQuery queryWithClassName: roomsTableName];
    [query whereKey:roomTitleFieldName equalTo:room.title];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            Response*r;
            r= [[Response alloc] initWithSuccess:NO andMessage: [error localizedDescription]];
            block(r);
        }
        else {
            PFObject *room = [objects objectAtIndex:0];
            [room[roomMessagesFieldName] addObject: message];
            [room saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    Response*r;
                    r = [[Response alloc]initWithSuccess:YES andMessage:@"Message was sent successfuly."];
                    block(r);
                }
                else {
                    Response*r;
                    r= [[Response alloc] initWithSuccess:NO andMessage: [error localizedDescription]];
                    block(r);
                }
            }];
        }
    }];
}

@end
