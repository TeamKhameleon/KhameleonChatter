#import "ChatViewController.h"
#import "ChatRoomTableView.h"

@interface ChatViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) NSString* locationString;

@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextInput;
@property (weak, nonatomic) IBOutlet UITextField *messageTitleTextInput;
@property (weak, nonatomic) IBOutlet UISwitch *geolocationSwitch;
@property (weak, nonatomic) IBOutlet ChatRoomTableView *messagesTable;

- (IBAction)onBackButtonClick:(id)sender;
- (IBAction)onAddPhotoButtonClick:(id)sender;
- (IBAction)onSendButtonClick:(id)sender;
- (IBAction) onLocationSwitchChange:(id)sender;

@end

@implementation ChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationHandler = [[GeoLocationHandler alloc] init];
    self.cameraHandler = [[CameraHandler alloc] init];
    self.dataRequester = [ServerData sharedInstance];
    self.currentMessage = [[ChatMessage alloc] initWithTitle: @""
                                                     message: @""
                                                   andSender: self.username];
    self.messageTitleTextInput.delegate = self;
    self.messageTextInput.delegate = self;
    [self onLocationSwitchChange: nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
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

- (IBAction) onLocationSwitchChange:(id)sender{
    if ([self.geolocationSwitch isOn]) {
        __weak ChatViewController* wSelf = self;
        [self.locationHandler getLocationWithBlock:^(CLLocation *location) {
            [wSelf.locationHandler getLocationString:location withBlock:^(NSString *locationString) {
                wSelf.locationString = locationString;
            }];
        }];
    }
    else {
        self.locationString = @"???";
    }
}

-(void)requestUpdate
{
    __weak ChatViewController * weakSelf = self;
    [self.dataRequester getUpdatedRoom: self.room withBlock:^(Response *r, ChatRooms *room) {
        if (r.success) {
            [weakSelf onUpdateRecieved:room];
        }
        else {
            [weakSelf alert:r.message];
        }
    }];
}

-(void)onUpdateRecieved: (ChatRooms*) updatedRoom {
    self.room = updatedRoom;
    self.messagesTable.messages = self.room.messages;
    [self.messagesTable reloadData];
}

-(void)sendMessage
{
    self.currentMessage.title = self.messageTitleTextInput.text;
    self.currentMessage.message = self.messageTextInput.text;
    
    self.currentMessage.location = self.locationString;
    
    __weak ChatViewController * weakSelf = self;
    [self.dataRequester sendMessage:self.currentMessage toRoom:self.room withBlock:^(Response *r) {
        if (r.success == NO) {
            [weakSelf alert:r.message];
        }
    }];
    
    [self.messageTextInput setText:@""];
    self.currentMessage = [[ChatMessage alloc] initWithTitle: self.messageTitleTextInput.text
                                                     message: @""
                                                   andSender: self.username];
    [self requestUpdate];
}

- (IBAction)onBackButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onAddPhotoButtonClick:(id)sender
{
    [self.currentMessage setPhoto: [self.cameraHandler getPhoto]];
}

- (IBAction)onSendButtonClick:(id)sender
{
    [self sendMessage];
}

@end
