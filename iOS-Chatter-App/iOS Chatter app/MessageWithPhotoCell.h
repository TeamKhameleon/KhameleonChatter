//
//  MessageWithPhotoCellTableViewCell.h
//  iOS Chatter app
//
//  Created by Alexander Dinkov on 11/2/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessage.h"

@interface MessageWithPhotoCell : UITableViewCell

-(void) setWithMessage: (ChatMessage*) message;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *messageImageView;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
