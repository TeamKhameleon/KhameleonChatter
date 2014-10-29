#import "RoomsListViewController.h"
#import "TelerikBackendData.h"
#import "LocalData.h"
#import "ChatRoom.h"

@interface RoomsListViewController ()

- (IBAction)onLogoutButtonClick:(id)sender;
- (IBAction)onEnterRoomButtonClick:(id)sender;

@end

@implementation RoomsListViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.dataRequester = [[TelerikBackendData alloc] init];
    self.localData = [[LocalData alloc] init];
    self.rooms = [self.localData getRooms];
    [self updateRooms];
    [self requestUpdate];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void) requestUpdate {
    // TODO : request the rooms and give "onUpdateRecieved" as callback
}

-(void) onUpdateRecieved: (RoomList*) rooms {
    BOOL roomsAreSame = YES;
    if (rooms.count != self.rooms.count) {
        roomsAreSame = NO;
    }
    else
    {
        for (int i = 0; i < rooms.count; i++) {
            ChatRoom* old = self.rooms[i];
            ChatRoom* new = rooms[i];
            if (old.title != new.title) {
                roomsAreSame = NO;
                break;
            }
        }
    }
    
    if (roomsAreSame == NO) {
        self.rooms = rooms;
        [self.localData updateRooms: rooms];
        [self updateRooms];
    }
}

-(void) updateRooms {
    // TODO : update the rooms of the view
}

-(void) enterRoom {
    // TODO : Determine withch room was selected
    // TODO : Enter the selected room
}


- (IBAction) onLogoutButtonClick:(id)sender {
    // TODO : go back
}

- (IBAction) onEnterRoomButtonClick:(id)sender {
    [self enterRoom];
}

@end