#import <UIKit/UIKit.h>
#import "ChatMessage.h"
#import "TelerikBackendData.h"
#import "GeoLocationHandler.h"

@interface ChatViewController : UIViewController

@property (nonatomic, strong) ChatMessage* currentMessage;
@property (nonatomic, strong) ChatRooms* room;
@property (nonatomic, strong) GeoLocationHandler* locationHandler;
@property (nonatomic, strong) TelerikBackendData* dataRequester;
@property (nonatomic, strong) NSString* username;

-(void)requestUpdate;
-(void)onUpdateRecieved: (ChatRooms*) updatedRoom;

-(void)sendMessage;

@end
