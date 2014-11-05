#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ChatRooms : PFObject<PFSubclassing>

-(instancetype) initWithTitle: (NSString*)title roomDescr:(NSString*)descr andMessages: (NSString*)messagess;
-(instancetype) initWithTitle: (NSString*)title andRoomDescr:(NSString*)descr;

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* roomDescription;
@property (nonatomic, strong) NSString* messages;

-(NSMutableArray*) getMessages;
-(void) setMessagesWithArray: (NSMutableArray*) messages;

@end
