#import <UIKit/UIKit.h>
#import "ServerData.h"
#import "LocalData.h"

@interface RoomsListViewController : UIViewController

@property (nonatomic, strong) NSArray* rooms;
@property (nonatomic, strong) LocalData* localData;
@property (nonatomic, strong) ServerData* dataRequester;
@property (nonatomic, strong) NSString* username;

-(void)requestUpdate;
-(void)onUpdateRecieved: (NSArray*) rooms;

-(void)enterRoom;

@end
