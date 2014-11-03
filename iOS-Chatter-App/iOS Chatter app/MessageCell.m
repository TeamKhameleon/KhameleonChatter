//
//  MessageCell.m
//  iOS Chatter app
//
//  Created by Alexander Dinkov on 11/2/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

-(void) setWithMessage: (ChatMessage*) message
{
    NSDateFormatter *formatter;
    NSString *dateString;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    dateString = [formatter stringFromDate: message.date];
    
    self.dateLabel.text = dateString;
    self.usernameLabel.text = message.sender;
    self.titleLabel.text = message.title;
    self.messageTextView.text = message.message;
    
    if (message.geolocation) {
        // TODO : Display location properly;
        NSString *locationText = [NSString stringWithFormat: @"from: %@", @"Sofia"];
        self.locationLabel.text = locationText;
    }
    else {
        self.locationLabel.text = @"hidden location...";
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
