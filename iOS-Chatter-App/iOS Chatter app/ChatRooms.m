#import "ChatRooms.h"
#import "ChatMessage.h"

@implementation ChatRooms

@dynamic title;
@dynamic roomDescription;
@dynamic messages;

+(NSString *)parseClassName {
    return @"ChatRooms";
}

-(instancetype) initWithTitle: (NSString*)title andRoomDescr:(NSString*)descr{
    if (self = [super init]) {
        self.title = title;
        self.roomDescription = descr;
        self.messages = @"[]";
    }
    return self;
}
-(instancetype) initWithTitle: (NSString*)title roomDescr:(NSString*)descr andMessages: (NSString*)messages {
    if (self = [super init]) {
        self.title = title;
        self.roomDescription = descr;
        self.messages = messages;
    }
    return self;
}


-(NSMutableArray*) getMessages {
    NSMutableArray* results = [[NSMutableArray alloc] init];
    NSData *returnedData = [self.messages dataUsingEncoding:NSUTF8StringEncoding];
    if(NSClassFromString(@"NSJSONSerialization"))
    {
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData: returnedData
                     options:0
                     error:&error];
        
        if(error)
        {
            NSLog(@"ChatRooms.getMessages ==>> no data, or error");
        }
        
        if([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *results = object;
            NSLog(@"Messages are dictionary: %@", results);
        }
        
        if([object isKindOfClass:[NSArray class]])
        {
            NSArray *resultObjects = object;
            NSLog(@"Messages are array: %@", resultObjects);
            for (int i = 0; i < [resultObjects count]; i++) {
                NSDictionary *msg = resultObjects[i];
                ChatMessage* message = [[ChatMessage alloc] initFromDictionary:msg];
                [results addObject:message];
            }
            
            
            NSInteger len= MIN(300, results.count);
            NSRange range = NSMakeRange(results.count - len, len);
            results = [NSMutableArray arrayWithArray:[results subarrayWithRange:range]];
        }
    }
    else
    {
        NSLog(@"ChatRooms.getMessages ==>> no JSON serializer available");
    }
    
    return results;
}

-(void) setMessagesWithArray: (NSMutableArray*) messages {
    NSData *json;
    NSError *error = nil;
    if ([NSJSONSerialization isValidJSONObject:messages])
    {
        // Serialize
        json = [NSJSONSerialization dataWithJSONObject:messages options:NSJSONWritingPrettyPrinted error:&error];
        
        // If no errors, let's view the JSON
        if (json != nil && error == nil)
        {
            NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            
            NSLog(@"JSON Serialization: %@", jsonString);
            self.messages = jsonString;
        }
        else {
            NSLog(@"ChatRooms.setMessagesWithArray:(NSMutableArray*)messages ==>> no data, or error");
        }
    }
    else {
        NSLog(@"ChatRooms.setMessagesWithArray:(NSMutableArray*)messages ==>> messages are not valid Json object");
    }
}


@end
