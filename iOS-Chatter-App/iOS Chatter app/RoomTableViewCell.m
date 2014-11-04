//
//  RoomTableViewCell.m
//  iOS Chatter app
//
//  Created by Alexander Dinkov on 11/2/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import "RoomTableViewCell.h"

@interface RoomTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UITextView *Description;

@end

@implementation RoomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setWithTile: (NSString*) title
      andDescription: (NSString*) description {
    self.Title.text = title;
    self.Description.text = description;
}

@end
