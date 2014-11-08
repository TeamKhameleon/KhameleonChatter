//
//  ChatRoom.h
//  iOS Chatter app
//
//  Created by Ivan Danov on 11/8/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CoreDataChatRoom : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * roomDescription;

-(instancetype) initWithTitle:(NSString*) title
           AndRoomDescription:(NSString*) roomDescription;

@end
