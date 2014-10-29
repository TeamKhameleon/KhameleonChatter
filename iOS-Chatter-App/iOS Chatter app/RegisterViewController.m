#import "RegisterViewController.h"
#import "TelerikBackendData.h"

@interface RegisterViewController ()

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
    self.dataRequester = [[TelerikBackendData alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)inputHasProblems: (NSString*) text {
    if ([text length] > 4) {
        return YES;
    }
    return NO;
}

-(void) loginUser {
    if ([self inputHasProblems: self.emailTextInput.text] == YES ||
        [self inputHasProblems: self.passwordTextInput.text] == YES) {
        // TODO : Display problem
        return;
    }
    
    Response* response = [self.dataRequester loginWithMail:self.emailTextInput.text
                                               andPassword:self.passwordTextInput.text];
    if (response.success == YES) {
        // TODO : Go to Chat Room selection
    }
    else {
        // TODO : Display problem
    }
}

-(void) registerUser {
    if ([self inputHasProblems: self.emailTextInput.text] == YES ||
        [self inputHasProblems: self.passwordTextInput.text] == YES) {
        // TODO : Display problem
        return;
    }
    
    Response* response = [self.dataRequester registerWithMail:self.emailTextInput.text
                                               andPassword:self.passwordTextInput.text];
    if (response.success == YES) {
        // TODO : Go to Chat Room selection
    }
    else {
        // TODO : Display problem
    }
}


- (IBAction)onQuitButtonClick:(id)sender {
}

- (IBAction)onRegisterButtonClick:(id)sender {
    [self registerUser];
}

- (IBAction)onLoginButtonClick:(id)sender {
    [self loginUser];
}

- (IBAction)onEmailValueChanged:(id)sender {
    if ([self inputHasProblems: self.emailTextInput.text] == YES) {
        // TODO : change background to red
    }
    else {
        // TODO : change background to none
    }
}

- (IBAction)onPasswordValueChanged:(id)sender {
    if ([self inputHasProblems: self.passwordTextInput.text] == YES) {
        // TODO : change background to red
    }
    else {
        // TODO : change background to none
    }
}

@end
