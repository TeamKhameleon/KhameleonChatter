#import "LocalData.h"
#import "CoreDataChatRoom.h"
#import "ChatRooms.h"
@implementation LocalData

NSString *storeFilename = @"CDatabase.sqlite";

-(NSArray*) getRooms {
    NSFetchRequest *allRooms = [NSFetchRequest fetchRequestWithEntityName:@"CoreDataChatRoom"];
    NSArray *fetchedObjects = [self.context executeFetchRequest:allRooms error:nil];
    
    NSMutableArray* resultRooms = [NSMutableArray array];
    
    for (CoreDataChatRoom *room in fetchedObjects) {
        ChatRooms* tempRoom = [[ChatRooms alloc] initWithTitle:room.title
                                                 andRoomDescr:room.roomDescription];
        [resultRooms addObject:tempRoom];
    }
    
    return [NSArray arrayWithArray:resultRooms];
}

-(Response*) updateRooms: (NSArray*) rooms {
    //delete all rooms
    NSFetchRequest *deleteRequest = [NSFetchRequest fetchRequestWithEntityName:@"CoreDataChatRoom"];
    NSArray *fetchedObjects = [self.context executeFetchRequest:deleteRequest error:nil];
    for (CoreDataChatRoom *room in fetchedObjects) {
        NSLog(@"Deleting Object '%@'", room.title);
        [self.context deleteObject:room];
    }
    [self saveContext];
    
    //foreach rooms create coredata model
    for(ChatRooms *chatRoom in rooms) {
        CoreDataChatRoom* tempRoom = [NSEntityDescription insertNewObjectForEntityForName:@"CoreDataChatRoom"
                                                           inManagedObjectContext:self.context];
        tempRoom.title = chatRoom.title;
        tempRoom.roomDescription = chatRoom.roomDescription;
        
        [self.context insertObject:tempRoom];
    }
    
    [self saveContext];
    
    return [[Response alloc] initWithSuccess:YES andMessage:@"faked"];
}

-(id) init
{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_context setPersistentStoreCoordinator:_coordinator];
    
    [self setupCoreData];
    
    return self;
}

- (NSURL *)storeURL
{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    return [[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename];
}

- (void)loadStore
{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if (_store) {
        return;
    }
    
    NSError *error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                        configuration:nil
                                                  URL:[self storeURL]
                                              options:nil
                                                error:&error];
    
    if (!_store) {
        NSLog(@"Failed to add store. Error: %@", error);
        abort();
    } else {
        NSLog(@"Successfully added store: %@", _store);
    }
}

- (void)setupCoreData
{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    [self loadStore];
}

- (NSString *)applicationDocumentsDirectory
{
    NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
}

- (void)saveContext
{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if ([_context hasChanges]) {
        NSError *error = nil;
        if ([_context save:&error]) {
            NSLog(@"_context SAVED changes to persistent store");
        } else {
            NSLog(@"Failed to save _context: %@", error);
        }
    } else {
        NSLog(@"SKIPPED _context save, there are no changes!");
    }
}

- (NSURL *)applicationStoresDirectory
{
    //NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    NSURL *storesDirectory =
    [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]]
     URLByAppendingPathComponent:@"Stores"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[storesDirectory path]]) {
        NSError *error = nil;
        if ([fileManager createDirectoryAtURL:storesDirectory
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:&error]) {
            //NSLog(@"Successfully created Stores directory");
        }
        else {
            NSLog(@"FAILED to create Stores directory: %@", error);
        }
    }
    return storesDirectory;
}


@end
