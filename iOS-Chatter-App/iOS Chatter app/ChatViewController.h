#import <UIKit/UIKit.h>
#import "ChatMessage.h"
#import "TelerickBackendData.h"

@interface ChatViewController : UIViewController

@property (nonatomic, strong) ChatMessage* currentMessage;
@property (nonatomic, strong) ChatRoom* room;
@property (nonatomic, strong) TelerickBackendData* dataRequester;

-(void)requestUpdate;
-(void)onUpdateRecieved: (ChatRoom*) updatedRoom;

-(void)sendMessage;

@end
