#import <UIKit/UIKit.h>
#import "TelerickBackendData.h"

@interface RegusterViewController : UIViewController

@property (nonatomic, strong) TelerickBackendData* dataRequester;

-(void) loginUser;
-(void) registerUser;

@end
