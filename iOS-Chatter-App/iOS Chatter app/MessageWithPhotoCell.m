//
//  MessageWithPhotoCellTableViewCell.m
//  iOS Chatter app
//
//  Created by Alexander Dinkov on 11/2/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import "MessageWithPhotoCell.h"

@implementation MessageWithPhotoCell

-(void) setWithMessage: (ChatMessage*) message
{
    NSDateFormatter *formatter;
    NSString *dateString;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    dateString = [formatter stringFromDate: message.date];
    
    self.dateLabel.text = dateString;
    self.usernameLabel.text = [NSString stringWithFormat: @"[%@]:",message.sender];
    self.titleLabel.text = [NSString stringWithFormat: @"< %@ >",message.title];
    self.messageTextView.text = message.message;
    
    if (message.location) {
        NSString *locationText = [NSString stringWithFormat: @"from: %@", message.location];
        self.locationLabel.text = locationText;
    }
    else {
        self.locationLabel.text = @"";
    }
    
    if (message.photo) {
        [self.imageView setImage: [message getPhoto]];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
