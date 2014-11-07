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

@interface ChatRoomTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSString* cellIdentifyer;
@property (nonatomic,strong) NSString* cellWithPhotoIdentifyer;

@end

@implementation ChatRoomTableView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.cellIdentifyer = @"MessageTableViewCell";
    self.cellWithPhotoIdentifyer = @"MessageTableViewCellWithPhoto";
    
    UINib* nib = [UINib nibWithNibName: self.cellIdentifyer
                                bundle: nil];
    
    [self registerNib: nib forCellReuseIdentifier: self.cellIdentifyer];
    
    UINib* nibPhoto = [UINib nibWithNibName: self.cellWithPhotoIdentifyer
                                bundle: nil];
    
    [self registerNib: nibPhoto forCellReuseIdentifier: self.cellWithPhotoIdentifyer];
    
    self.delegate = self;
    self.dataSource = self;
}

-(NSInteger)numberOfSections {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessage* message = self.messages[indexPath.row];
    
    if (message.photo) {
        MessageWithPhotoCell* cell = [self dequeueReusableCellWithIdentifier: self.cellWithPhotoIdentifyer
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessage* message = self.messages[indexPath.row];
    
    if (message.photo) {
        return 228.0;
    }
    else {
        return 136.0;
    }
}

-(void)scrollToBottom {
    NSIndexPath * ndxPath= [NSIndexPath indexPathForRow:self.messages.count-1 inSection:0];
    [self scrollToRowAtIndexPath : ndxPath
                atScrollPosition : UITableViewScrollPositionTop
                        animated : YES];
}

@end
