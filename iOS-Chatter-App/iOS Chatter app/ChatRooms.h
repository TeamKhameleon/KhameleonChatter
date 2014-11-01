#import <Foundation/Foundation.h>
#import <EverliveSDK/EverliveSDK.h>

@interface ChatRooms : EVObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* roomDescription;
@property (nonatomic, strong) NSString* roomId;
@property (nonatomic, strong) NSMutableArray* messages;

@end
