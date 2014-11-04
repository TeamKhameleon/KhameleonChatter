#import <UIKit/UIKit.h>
#import "ServerData.h"

@interface RegisterViewController : UIViewController

@property (nonatomic, strong) ServerData* dataRequester;

-(void) loginUser;
-(void) registerUser;

@end
