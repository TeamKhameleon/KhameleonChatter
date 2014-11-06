#import "ServerData.h"
#import "ChatRooms.h"
#import <Parse/Parse.h>

@interface ServerData()

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

NSString *username = @"???";

ServerData *instance;

-(instancetype) init
{
    self = [super init];
    return self;
}

+(NSString *)getUsername {
    return username;
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
            if (objects != nil && [objects count] > 0) {
                username=name;
                NSString* message = [NSString stringWithFormat:@"User %@ is now logged in" , name];
                block([[Response alloc]initWithSuccess:YES andMessage:message]);
            }
            else {
                block([[Response alloc]initWithSuccess:NO andMessage:@"Incorrect email or password."]);
            }
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
    
    PFQuery *query = [PFQuery queryWithClassName: usersTableName];
    [query whereKey:usersEmailFieldName equalTo:email];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects != nil && [objects count] > 0) {
            block([[Response alloc]initWithSuccess:NO andMessage:@"This user already exists."]);
        }
        else {
            PFObject *testObject = [PFObject objectWithClassName: usersTableName];
            testObject[usersNameFieldName] = name;
            testObject[usersEmailFieldName] = email;
            testObject[usersPasswordFieldName] = password;
            [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    username=name;
                    NSString* message = [NSString stringWithFormat:@"User %@ is now registered" , name];
                    block([[Response alloc]initWithSuccess:YES andMessage:message]);
                }
                else {
                    block([[Response alloc]initWithSuccess:NO andMessage:@"Could not register user."]);
                }
            }];
        }
    }];
}


-(void) getRoomsWithBlock: (void(^)(Response*r, NSArray*rooms)) block
{
    PFQuery *query = [PFQuery queryWithClassName: [ChatRooms parseClassName]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        Response*r;
        if (error) {
            r= [[Response alloc] initWithSuccess:NO andMessage: [error localizedDescription]];
        }
        else {
            r = [[Response alloc]initWithSuccess:YES andMessage:@"Rooms were successfuly accuired."];
        }
        NSMutableArray *results = [[NSMutableArray alloc] init];
        for (PFObject*obj in objects) {
            ChatRooms*room = [[ChatRooms alloc] initWithTitle: [obj valueForKey:roomTitleFieldName]
                                                    roomDescr: [obj valueForKey:roomDescrFieldName]
                                                  andMessages: [obj valueForKey:roomMessagesFieldName]];
            [results addObject: room];
        }
        block(r, results);
    }];
}

-(void)getUpdatedRoom: (ChatRooms*) room
            withBlock: (void(^)(Response*r, ChatRooms*room)) block
{
    
    PFQuery *query = [PFQuery queryWithClassName: [ChatRooms parseClassName]];
    [query whereKey:roomTitleFieldName equalTo:room.title];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        Response*r;
        if (error) {
            r= [[Response alloc] initWithSuccess:NO andMessage: [error localizedDescription]];
            block(r, room);
        }
        else {
            if (objects == nil || objects.count < 1) {
                r = [[Response alloc]initWithSuccess:NO andMessage:@"Room not found."];
                block(r, room);
            }
            else {
                PFObject *nRoom = [objects objectAtIndex:0];
                r = [[Response alloc]initWithSuccess:YES andMessage:@"Room were successfuly updated."];
                [room setMessages: [nRoom valueForKey: roomMessagesFieldName]];
                block(r, room);
            }
        }
        
    }];
}

-(void)sendMessage: (ChatMessage*) message
            toRoom: (ChatRooms*) room
         withBlock: (void(^)(Response*r)) block
{
    NSMutableArray *msgs = [room getMessages];
    [msgs addObject: message];
    [room setMessagesWithArray: msgs];
    
    PFQuery *query = [PFQuery queryWithClassName: roomsTableName];
    [query whereKey:roomTitleFieldName equalTo:room.title];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            Response*r;
            r= [[Response alloc] initWithSuccess:NO andMessage: [error localizedDescription]];
            block(r);
        }
        else {
            PFObject *foundRoom = [objects objectAtIndex:0];
            foundRoom[roomMessagesFieldName] = room.messages;
            [foundRoom saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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
