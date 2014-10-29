#import <UIKit/UIKit.h>
#import "ChatMessage.h"
#import "TelerikBackendData.h"

@interface ChatViewController : UIViewController

@property (nonatomic, strong) ChatMessage* currentMessage;
@property (nonatomic, strong) ChatRoom* room;
@property (nonatomic, strong) TelerikBackendData* dataRequester;
@property (nonatomic, strong) NSString* username;

-(void)requestUpdate;
-(void)onUpdateRecieved: (ChatRoom*) updatedRoom;

-(void)sendMessage;

@end
