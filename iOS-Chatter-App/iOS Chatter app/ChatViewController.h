#import <UIKit/UIKit.h>
#import "ChatMessage.h"
#import "TelerickBackendData.h"

@interface ChatViewController : UIViewController

@property (nonatomic, strong) ChatMessage* currentMessage;
@property (nonatomic, strong) NSArray* messages;
@property (nonatomic, strong) TelerickBackendData* dataRequester;

-(void)requestUpdate;
-(void)onUpdateRecieved: (NSArray*) messages;

-(void)sendMessage;

@end
