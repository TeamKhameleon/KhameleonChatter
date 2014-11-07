#import <Foundation/Foundation.h>

@interface CameraHandler : NSObject

@property (nonatomic, strong) id sender;

-(instancetype) initWithView: (id) sender
                       image: (UIImage*) image;
-(UIImage*) getPhoto;
+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
