//
//  RoomTableViewCell.h
//  iOS Chatter app
//
//  Created by Alexander Dinkov on 11/2/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomTableViewCell : UITableViewCell


- (void) setWithTile: (NSString*) title
      andDescription: (NSString*) description;

@end
