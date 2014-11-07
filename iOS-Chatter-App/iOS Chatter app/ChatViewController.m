#import "ChatViewController.h"
#import "ChatRoomTableView.h"

@interface ChatViewController () <UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSString* locationString;
@property (strong, nonatomic) NSDate* dateOfLastTap;
@property (strong, nonatomic) UIImage* uploadImage;
@property BOOL refresh;

@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextInput;
@property (weak, nonatomic) IBOutlet UITextField *messageTitleTextInput;
@property (weak, nonatomic) IBOutlet UISwitch *geolocationSwitch;
@property (weak, nonatomic) IBOutlet ChatRoomTableView *messagesTable;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (strong, nonatomic) IBOutlet UIScreenEdgePanGestureRecognizer *edgePanRecogniser;

- (IBAction)onAddPhotoButtonClick:(id)sender;
- (IBAction)onSendButtonClick:(id)sender;
- (IBAction) onLocationSwitchChange:(id)sender;

- (IBAction)onTap:(UITapGestureRecognizer *)sender;
- (IBAction)onHold:(UILongPressGestureRecognizer *)sender;
- (IBAction)onPan:(UIPanGestureRecognizer *)sender;
- (IBAction)onEdgePan:(UIScreenEdgePanGestureRecognizer *)sender;

@end

@implementation ChatViewController
NSInteger tagOfWholeView = 1001;
NSInteger centerX = 0;
NSInteger centerY = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    centerX = self.view.bounds.size.width / 2;
    centerY = self.view.bounds.size.height / 2;
    
    self.roomNameLabel.text = self.room.title;
    
    self.locationHandler = [[GeoLocationHandler alloc] init];
    
    
    
//    self.cameraHandler = [[CameraHandler alloc] initWithView:self
//                                                       image:self.uploadImage];
    
    self.dataRequester = [ServerData sharedInstance];
    self.currentMessage = [[ChatMessage alloc] initWithTitle: @""
                                                     message: @""
                                                   andSender: [ServerData getUsername]];
    self.messageTitleTextInput.delegate = self;
    self.messageTextInput.delegate = self;
    
    self.edgePanRecogniser.edges = UIRectEdgeLeft;
    
    self.locationString = @"???";
    [self onLocationSwitchChange: self.geolocationSwitch];
    
    self.refresh = YES;
    [self requestUpdate];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
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
    UISwitch *sw = (UISwitch*)sender;
    if ([sw isOn]) {
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
    
    if (self.refresh ==  YES){
        [NSTimer scheduledTimerWithTimeInterval:3.0
                                         target:self
                                       selector:@selector(requestUpdate)
                                       userInfo:nil
                                        repeats:NO];
    }
}

-(void)onUpdateRecieved: (ChatRooms*) updatedRoom {
    self.room = updatedRoom;
    self.messagesTable.messages = [self.room getMessages];
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
                                                   andSender: [ServerData getUsername]];
    [self requestUpdate];
    [self scrowToBottomOfChat];
}

- (IBAction)onAddPhotoButtonClick:(id)sender
{
    //[self.cameraHandler getPhoto];
    //[self.currentMessage setPhotoWithObject: [self.cameraHandler getPhoto]];
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Upload picture"
                                                      message:@"Choose method:"
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"Take photo", @"Select photo", nil];
    [message show];
}
//----------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Take photo"])
    {
        [self takePhoto];
    }
    else if([title isEqualToString:@"Select photo"])
    {
        [self selectPhoto];
    }
}
-(void) selectPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)takePhoto{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.uploadImage = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
//----------------END-----

- (IBAction)onSendButtonClick:(id)sender
{
    [self.currentMessage setPhotoWithObject: self.uploadImage];
    [self sendMessage];
    self.uploadImage = nil;
}

- (void) scrowToBottomOfChat {
    [self.messagesTable scrollToBottom];
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    NSDate* dateNow = [NSDate date];
    
    if(self.dateOfLastTap != nil && [dateNow timeIntervalSinceDate: self.dateOfLastTap] < .3){
        [self scrowToBottomOfChat];
    }
    else {
        self.dateOfLastTap = dateNow;
    }
}

- (IBAction)onHold:(UILongPressGestureRecognizer *)sender {
    [self scrowToBottomOfChat];
}

- (IBAction)onEdgePan:(UIScreenEdgePanGestureRecognizer *)gesture {
    UIView *view = [self.view viewWithTag: tagOfWholeView];
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state) {
        CGPoint translation = [gesture translationInView:gesture.view];
        view.center = CGPointMake(centerX + translation.x, view.center.y);
        if (translation.x > centerX) {
            [self.backBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    } else {
        [UIView animateWithDuration:.3 animations:^{
            view.center = CGPointMake(centerX, view.center.y);
        }];
    }
}


- (IBAction)onPan:(UIPanGestureRecognizer *)gesture {
    UIView *view = [self.view viewWithTag: tagOfWholeView];
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state) {
        
        CGPoint translation = [gesture translationInView:gesture.view];
        if (translation.x > translation.y /3) {
            view.center = CGPointMake(centerX + translation.x, view.center.y);
            if (translation.x > centerX) {
                [self.backBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
        }
    } else {
        [UIView animateWithDuration:.3 animations:^{
            view.center = CGPointMake(centerX, view.center.y);
        }];
    }
}

@end
