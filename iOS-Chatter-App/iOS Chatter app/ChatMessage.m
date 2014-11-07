#import "ChatMessage.h"
#import "CameraHandler.h"

@implementation ChatMessage

+(NSString*)dateToString: (NSDate*)date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    return [dateFormat stringFromDate:date];
}

-(instancetype) initFromDictionary: (NSDictionary*) message {
    if (self = [super init]) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
        NSDate *date = [dateFormat dateFromString: message[@"date"]];
        
        self.title = message[@"title"];
        self.message = message[@"message"];
        self.sender = message[@"sender"];
        self.date = date;
        self.photo = message[@"photo"];
        self.location = message[@"location"];
    }
    return self;
}

-(instancetype) initWithTitle: (NSString*) title
                      message: (NSString*) message
                    andSender: (NSString*) sender {
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.sender = sender;
        self.date = [NSDate date];
    }
    return self;
}

-(void) setGeoLocation: (NSString*) location {
    self.location = location;
}


- (void) setPhotoWithObject: (UIImage*) photo
{
    if(!photo) {
        self.photo = nil;
        return;
    }
    
    //Convert an Image to String
    //UIImage *anImage;
    //NSString *imageString = [UIImagePNGRepresentation(photo) base64EncodedStringWithOptions:0];
    //self.photo = imageString;
    
    
    UIImage *smallImage = [CameraHandler imageWithImage:photo scaledToSize:CGSizeMake(50, 30)];
    
    NSData *data = [UIImagePNGRepresentation(smallImage) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    self.photo = [NSString stringWithUTF8String:[data bytes]];
}

- (UIImage*) getPhoto
{
    //To retrieve
    //NSData *data = [self.photo dataUsingEncoding:NSUTF8StringEncoding];
    //UIImage *recoverImage = [UIImage imageWithData: data];
    // return recoverImage;
    
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self.photo options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [UIImage imageWithData:data];
}



@end
