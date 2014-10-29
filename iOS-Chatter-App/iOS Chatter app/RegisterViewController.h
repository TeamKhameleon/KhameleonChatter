#import <UIKit/UIKit.h>
#import "TelerikBackendData.h"

@interface RegisterViewController : UIViewController

@property (nonatomic, strong) TelerikBackendData* dataRequester;

-(void) loginUser;
-(void) registerUser;

@end
