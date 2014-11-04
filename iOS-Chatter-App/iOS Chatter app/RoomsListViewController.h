#import <UIKit/UIKit.h>
#import "ServerData.h"
#import "LocalData.h"

@interface RoomsListViewController : UIViewController

@property (nonatomic, strong) RoomList* rooms;
@property (nonatomic, strong) LocalData* localData;
@property (nonatomic, strong) ServerData* dataRequester;
@property (nonatomic, strong) NSString* username;

-(void)requestUpdate;
-(void)onUpdateRecieved: (RoomList*) rooms;

-(void)enterRoom;

@end
