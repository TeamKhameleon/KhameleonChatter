#import "ChatRooms.h"


@implementation ChatRooms

-(NSDictionary*) getEverlivePropertiesMapping
{
    return @{
             @"title" : @"Name",
             @"roomDescription" : @"Description",
             @"roomId" : @"Id",
             @"messages" : @"Messages"
             };
}

@end
