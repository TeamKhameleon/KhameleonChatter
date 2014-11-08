//
//  ChatRoom.m
//  iOS Chatter app
//
//  Created by Ivan Danov on 11/8/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import "CoreDataChatRoom.h"


@implementation CoreDataChatRoom

@dynamic title;
@dynamic roomDescription;

-(instancetype) initWithTitle:(NSString *)title
           AndRoomDescription:(NSString *)roomDescription {
    
    self = [super init];
    if (self) {
        self.title = title;
        self.roomDescription = roomDescription;
    }
    
    return self;
}

@end
