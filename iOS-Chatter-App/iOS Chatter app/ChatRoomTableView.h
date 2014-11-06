//
//  ChatRoomTableView.h
//  iOS Chatter app
//
//  Created by Alexander Dinkov on 11/2/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessage.h"

@interface ChatRoomTableView : UITableView

@property (nonatomic, strong) NSMutableArray* messages;

-(void)scrollToBottom;

@end
