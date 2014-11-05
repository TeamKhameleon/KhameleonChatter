#import "RoomsListViewController.h"
#import "ServerData.h"
#import "LocalData.h"
#import "ChatRooms.h"
#import "RoomSelectionTableView.h"
#import "ChatViewController.h"

@interface RoomsListViewController ()

@property (weak, nonatomic) IBOutlet RoomSelectionTableView *roomsTable;

- (IBAction)onLogoutButtonClick:(id)sender;
- (IBAction)onEnterRoomButtonClick:(id)sender;

@end

@implementation RoomsListViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.dataRequester = [ServerData sharedInstance];
    self.localData = [[LocalData alloc] init];
    self.rooms = [self.localData getRooms];
    [self updateRooms];
    [self requestUpdate];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) alert: (NSString*)str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message: str
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void) requestUpdate {
    __weak RoomsListViewController* weakself = self;
    [self.dataRequester getRoomsWithBlock:^(Response *r, NSArray *rooms) {
        if (r.success) {
            [weakself onUpdateRecieved:rooms];
        }
        else {
            [weakself alert:r.message];
        }
    }];
}

-(void) onUpdateRecieved: (NSArray*) rooms {
    BOOL roomsAreSame = YES;
    if ([rooms count] != [self.rooms count]) {
        roomsAreSame = NO;
    }
    else
    {
        for (int i = 0; i < rooms.count; i++) {
            ChatRooms* old = self.rooms[i];
            ChatRooms* new = rooms[i];
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
    self.roomsTable.rooms = self.rooms;
    [self.roomsTable reloadData];
}

-(void) enterRoom {
    NSIndexPath *selectedIP = [self.roomsTable indexPathForSelectedRow];
    ChatRooms *selectedRoom = self.rooms[selectedIP.row];
    
    ChatViewController *viewController;
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Chat"];
    //viewController = [[ChatViewController alloc] init];
    viewController.room = selectedRoom;
    [self presentViewController:viewController animated:YES completion:nil];
}


- (IBAction) onLogoutButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) onEnterRoomButtonClick:(id)sender {
    [self enterRoom];
}

@end