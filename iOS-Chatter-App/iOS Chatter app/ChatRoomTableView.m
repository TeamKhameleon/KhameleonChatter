//
//  ChatRoomTableView.m
//  iOS Chatter app
//
//  Created by Alexander Dinkov on 11/2/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import "ChatRoomTableView.h"
#import "MessageCell.h"
#import "MessageWithPhotoCell.h"

@interface ChatRoomTableView ()

@property (nonatomic,strong) NSString* cellIdentifyer;
@property (nonatomic,strong) NSString* cellWithPhotoIdentifyer;

@end

@implementation ChatRoomTableView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.cellIdentifyer = @"MessageCell";
    self.cellWithPhotoIdentifyer = @"MessageWithPhotoCell";
    
    UINib* nib = [UINib nibWithNibName: self.cellIdentifyer
                                bundle: nil];
    [self registerNib: nib forCellReuseIdentifier: self.cellIdentifyer];
}

-(NSInteger)numberOfSections {
    return 1;
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

-(UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessage* message = self.messages[indexPath.row];
    
    if (message.photo) {
        MessageWithPhotoCell* cell = [self dequeueReusableCellWithIdentifier: self.cellIdentifyer
                                          forIndexPath:indexPath];
        [cell setWithMessage:message];
        return cell;
    }
    else {
        MessageCell* cell = [self dequeueReusableCellWithIdentifier: self.cellIdentifyer
                                                      forIndexPath:indexPath];
        [cell setWithMessage:message];
        return cell;
    }
}

- (BOOL)canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
