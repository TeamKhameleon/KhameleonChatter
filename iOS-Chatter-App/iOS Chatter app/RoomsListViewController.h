#import <UIKit/UIKit.h>
#import "TelerickBackendData.h"

@interface RoomsListViewController : UIViewController

@property (nonatomic, strong) NSArray* rooms;
@property (nonatomic, strong) TelerickBackendData* dataRequester;

-(void)requestUpdate;
-(void)onUpdateRecieved: (RoomList*) rooms;

-(void)enterRoom;

@end
