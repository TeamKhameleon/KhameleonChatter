#import "RoomsListViewController.h"
#import "ServerData.h"
#import "LocalData.h"
#import "ChatRooms.h"
#import "RoomSelectionTableView.h"
#import "ChatViewController.h"
#import "ViewTransitor.h"
#import "NotificationInvoker.h"

@interface RoomsListViewController ()

@property (weak, nonatomic) IBOutlet RoomSelectionTableView *roomsTable;

@property (strong, nonatomic) NSDate *dateOfLastTap;

- (IBAction)onEnterRoomButtonClick:(id)sender;

- (IBAction)onHold:(UILongPressGestureRecognizer *)sender;
- (IBAction)onTap:(UITapGestureRecognizer *)sender;
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
    
    
    NotificationInvoker* notificationInvoker = [[NotificationInvoker alloc] init];
    
    [notificationInvoker invokeNotificationWithMessage:@"You succesfully logged in!"
                                         AndAppearDate:[NSDate dateWithTimeIntervalSinceNow:5]];
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
    self.rooms = rooms;
    [self.localData updateRooms: rooms];
    [self updateRooms];
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
    
//    __weak UIViewController *wViewContr = viewController;
    [self presentViewController:viewController animated:YES completion:^{
    }];
    
}

- (IBAction) onEnterRoomButtonClick:(id)sender {
    [self enterRoom];
}

-(IBAction)returnToRooms:(UIStoryboardSegue*) segue{
    NSLog(@"Back to rooms");
}


- (IBAction)onHold:(UILongPressGestureRecognizer *)sender {
    [self enterRoom];
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    NSDate* dateNow = [NSDate date];
    
    if(self.dateOfLastTap != nil && [dateNow timeIntervalSinceDate: self.dateOfLastTap] < .3){
        [self enterRoom];
    }
    else {
        self.dateOfLastTap = dateNow;
    }
}

@end