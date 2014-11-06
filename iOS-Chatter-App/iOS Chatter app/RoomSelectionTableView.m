//
//  RoomSelectionTableView.m
//  iOS Chatter app
//
//  Created by Alexander Dinkov on 11/2/14.
//  Copyright (c) 2014 Siko. All rights reserved.
//

#import "RoomTableViewCell.h"
#import "RoomSelectionTableView.h"

@interface RoomSelectionTableView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSString* cellIdentifyer;

@end

@implementation RoomSelectionTableView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.cellIdentifyer = @"RoomSelectionTableViewCell";
    
    UINib* nib = [UINib nibWithNibName: self.cellIdentifyer
                                bundle: nil];
    [self registerNib: nib
         forCellReuseIdentifier: self.cellIdentifyer];
    
    self.delegate = self;
    self.dataSource = self;
}

- (NSInteger)numberOfSections{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rooms.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomTableViewCell *cell = [self dequeueReusableCellWithIdentifier: self.cellIdentifyer
                                                         forIndexPath:indexPath];
    ChatRooms *room = self.rooms[indexPath.row];
    [cell setWithTile:room.title
       andDescription:room.roomDescription];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 99.0;
}

@end
