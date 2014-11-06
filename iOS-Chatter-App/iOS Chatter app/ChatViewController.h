#import <UIKit/UIKit.h>
#import "ChatMessage.h"
#import "ServerData.h"
#import "GeoLocationHandler.h"
#import "CameraHandler.h"

@interface ChatViewController : UIViewController

@property (nonatomic, strong) ChatMessage* currentMessage;
@property (nonatomic, strong) ChatRooms* room;
@property (nonatomic, strong) GeoLocationHandler* locationHandler;
@property (nonatomic, strong) CameraHandler* cameraHandler;
@property (nonatomic, strong) ServerData* dataRequester;

-(void)requestUpdate;
-(void)onUpdateRecieved: (ChatRooms*) updatedRoom;

-(void)sendMessage;

@end
