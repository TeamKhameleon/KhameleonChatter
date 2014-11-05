#import "RegisterViewController.h"
#import "ServerData.h"
#import "RoomsListViewController.h"
#import "ConnectionHandler.h"

@interface RegisterViewController () <UITextFieldDelegate>

@property (strong, nonatomic) ConnectionHandler *connectionHandler;

@property (weak, nonatomic) IBOutlet UILabel *connectionStatus;
@property (weak, nonatomic) IBOutlet UITextField *emailTextInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextInput;

- (IBAction)onQuitButtonClick:(id)sender;
- (IBAction)onRegisterButtonClick:(id)sender;
- (IBAction)onLoginButtonClick:(id)sender;

- (IBAction)onEmailValueChanged:(id)sender;
- (IBAction)onPasswordValueChanged:(id)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataRequester = [ServerData sharedInstance];
    self.emailTextInput.delegate = self;
    self.passwordTextInput.delegate = self;
    self.connectionHandler = [[ConnectionHandler alloc] init];
    if (![self.connectionHandler isConnectedToInternet]) {
        self.connectionStatus.text = @"not connected";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)inputHasProblems: (NSString*) text {
    if ([text length] < 4) {
        return YES;
    }
    return NO;
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

-(void) loginUser {
    if ([self inputHasProblems: self.emailTextInput.text] == YES){
        [self alert:@"Your email address is too short"];
        return;
    }
    if([self inputHasProblems: self.passwordTextInput.text] == YES) {
        [self alert:@"Your password is too short"];
        return;
    }
    __weak RegisterViewController* weakSelf = self;
    [self.dataRequester loginWithMail:self.emailTextInput.text password:self.passwordTextInput.text andBlock:^(Response *r) {
        if (r.success == YES) {
            [self goToTheRoomsList];
        }
        else {
            [weakSelf alert:r.message];
        }
    }];
}

-(void) registerUser {
    if ([self inputHasProblems: self.emailTextInput.text] == YES){
        [self alert:@"Your email address is too short"];
        return;
    }
    if([self inputHasProblems: self.passwordTextInput.text] == YES) {
        [self alert:@"Your password is too short"];
        return;
    }
    
    __weak RegisterViewController* weakSelf = self;
    [self.dataRequester registerWithMail:self.emailTextInput.text password:self.passwordTextInput.text andBlock:^(Response *r) {
        if (r.success == YES) {
            [self goToTheRoomsList];
        }
        else {
            [weakSelf alert:r.message];
        }
    }];
}

-(void)goToTheRoomsList {
    
    RoomsListViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RoomsList"];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)onQuitButtonClick:(id)sender {
    exit(0);
}

- (IBAction)onRegisterButtonClick:(id)sender {
    [self registerUser];
}

- (IBAction)onLoginButtonClick:(id)sender {
    [self loginUser];
}

- (IBAction)onEmailValueChanged:(id)sender {
    if ([self inputHasProblems: self.passwordTextInput.text] == YES) {
        [self.emailTextInput setBackgroundColor:[UIColor redColor]];
    }
    else {
        [self.emailTextInput setBackgroundColor:[UIColor clearColor]];
    }
}

- (IBAction)onPasswordValueChanged:(id)sender {
    if ([self inputHasProblems: self.passwordTextInput.text] == YES) {
        [self.passwordTextInput setBackgroundColor:[UIColor redColor]];
    }
    else {
        [self.passwordTextInput setBackgroundColor:[UIColor clearColor]];
    }
}

@end
