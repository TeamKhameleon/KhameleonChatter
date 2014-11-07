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

@implementation RoomSelectionTableView {
    NSInteger selectedNumber;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    selectedNumber = 0;
    self.cellIdentifyer = @"RoomSelectionTableViewCell";
    
    UINib* nib = [UINib nibWithNibName: self.cellIdentifyer
                                bundle: nil];
    [self registerNib: nib
         forCellReuseIdentifier: self.cellIdentifyer];
    
    self.delegate = self;
    self.dataSource = self;
    
    UISwipeGestureRecognizer* swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onSwipeUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer* swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onSwipeDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self addGestureRecognizer:swipeUp];
    [self addGestureRecognizer:swipeDown];
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
    if ([indexPath row] == selectedNumber) {
        return  99;
    }
    else return 40;
}

-(void)selectCell: (NSInteger)r {
    self.currentRoom = self.rooms[r];
    NSIndexPath *path = [NSIndexPath indexPathForRow:r inSection:0];
    [self selectRowAtIndexPath: path
                      animated: YES
                scrollPosition: UITableViewScrollPositionMiddle];
}

-(void) onSwipeUp {
    if (selectedNumber > 0) {
        selectedNumber--;
    }
    [self selectCell: selectedNumber];
}

-(void) onSwipeDown {
    if (selectedNumber < self.rooms.count-1) {
        selectedNumber++;
    }
    [self selectCell: selectedNumber];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    selectedNumber = row;
    [tableView beginUpdates];
    [tableView endUpdates];
}

@end
