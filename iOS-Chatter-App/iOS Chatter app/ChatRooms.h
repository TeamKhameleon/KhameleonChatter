#import <Foundation/Foundation.h>
@interface ChatRooms : NSObject

-(instancetype) initWithTitle: (NSString*)title roomDescr:(NSString*)descr andMessages: (NSMutableArray*)messagess;
-(instancetype) initWithTitle: (NSString*)title andRoomDescr:(NSString*)descr;

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* roomDescription;
@property (nonatomic, strong) NSMutableArray* messages;

@end
