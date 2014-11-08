#import <Foundation/Foundation.h>
#import "Response.h"
#import <CoreData/CoreData.h>

@interface LocalData : NSObject

// we will only store rooms. No messages will be stored. This allows us to have faster loading.

@property(nonatomic,strong) NSManagedObjectContext* context;
@property(nonatomic, strong) NSManagedObjectModel* model;
@property(nonatomic, strong) NSPersistentStoreCoordinator* coordinator;
@property(nonatomic, strong) NSPersistentStore* store;

- (void)saveContext;
- (void)setupCoreData;

-(NSArray*) getRooms;
-(Response*) updateRooms: (NSArray*) rooms;

@end
