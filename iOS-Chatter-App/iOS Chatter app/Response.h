#import <Foundation/Foundation.h>

@interface Response : NSObject

-(instancetype) initWithSuccess: (BOOL) success
                     andMessage: (NSString*) message;

@property (nonatomic, strong) NSString* message;
@property BOOL success;

@end
