#import <Foundation/Foundation.h>

@interface ChatRoom : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, strong) NSString* roomId;
@property (nonatomic, strong) NSArray* messages;

@end
