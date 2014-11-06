#import <Foundation/Foundation.h>

@interface ChatRooms : NSObject

-(instancetype) initWithTitle: (NSString*)title roomDescr:(NSString*)descr andMessages: (NSString*)messagess;
-(instancetype) initWithTitle: (NSString*)title andRoomDescr:(NSString*)descr;

+(NSString *)parseClassName;

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* roomDescription;
@property (nonatomic, strong) NSString* messages;

-(NSMutableArray*) getMessages;
-(void) setMessagesWithArray: (NSMutableArray*) messages;

@end
