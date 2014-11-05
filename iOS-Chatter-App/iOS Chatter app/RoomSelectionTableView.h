//
//  RoomSelectionTableView.h
//  iOS Chatter app
//
//  Created by Alexander Dinkov on 11/2/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatRooms.h"

@interface RoomSelectionTableView : UITableView

@property  (nonatomic, strong) NSArray* rooms;
@property  (nonatomic, strong) ChatRooms* currentRoom;

@end
