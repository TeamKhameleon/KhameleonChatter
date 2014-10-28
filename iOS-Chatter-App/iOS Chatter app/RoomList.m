#import "RoomList.h"
#import "ChatRoom.h"

@implementation RoomList

-(void)onInvalidInitialization {
    [NSException raise:@"This init method should not be used" format:@"Usse empty initialization instead!"];
}


-(instancetype) initWithArray:(NSArray *)array {
    [self onInvalidInitialization];
    return self;
}
-(instancetype)initWithArray:(NSArray *)array copyItems:(BOOL)flag {
    [self onInvalidInitialization];
    return self;
}
-(instancetype) initWithObjects:(id)firstObj, ...{
    [self onInvalidInitialization];
    return self;
}
-(instancetype)initWithObjects:(const id [])objects count:(NSUInteger)cnt{
    [self onInvalidInitialization];
    return self;
}

-(void)addObject:(id)anObject {
    if ([anObject isKindOfClass: [ChatRoom class]]) {
        [super addObject:anObject];
    }
}

@end
