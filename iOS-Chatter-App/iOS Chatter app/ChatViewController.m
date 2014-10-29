#import "ChatViewController.h"

@interface ChatViewController ()

@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextInput;
@property (weak, nonatomic) IBOutlet UITextField *messageTitleTextInput;

- (IBAction)onBackButtonClick:(id)sender;
- (IBAction)onAddPhotoButtonClick:(id)sender;
- (IBAction)onSendButtonClick:(id)sender;

@end

@implementation ChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataRequester = [[TelerikBackendData alloc] init];
    self.currentMessage = [[ChatMessage alloc] initWithTitle: @""
                                                     message: @""
                                                   andSender: self.username];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)requestUpdate
{
    // TODO : request the rooms and give "onUpdateRecieved" as callback
}

-(void)onUpdateRecieved: (ChatRoom*) updatedRoom {
    // TODO : Update the messages
}

-(void)sendMessage
{
    self.currentMessage.title = self.messageTitleTextInput.text;
    self.currentMessage.message = self.messageTextInput.text;
    
    [self.dataRequester sendMessage: self.currentMessage
                             toRoom: self.room];
    
    [self.messageTextInput setText:@""];
    self.currentMessage = [[ChatMessage alloc] initWithTitle: self.messageTitleTextInput.text
                                                     message: @""
                                                   andSender: self.username];
    [self requestUpdate];
}

- (IBAction)onBackButtonClick:(id)sender
{
    // TODO : go back
}

- (IBAction)onAddPhotoButtonClick:(id)sender
{
    // TODO : add photo to message
}

- (IBAction)onSendButtonClick:(id)sender
{
    [self sendMessage];
}

@end
