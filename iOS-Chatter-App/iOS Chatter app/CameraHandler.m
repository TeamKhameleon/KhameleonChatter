#import "CameraHandler.h"

@interface CameraHandler () <UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) UIImage* image;

@end

@implementation CameraHandler


-(instancetype) initWithView: (id) sender
                       image: (UIImage*) image{
    if (self = [super init]) {
        self.sender = sender;
        //image = self.image;
        self.image = image;
    }
    return self;
}

-(UIImage *)getPhoto{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Upload picture"
                                                      message:@"Choose method:"
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"Take photo", @"Select photo", nil];
    [message show];
    
    return nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Take photo"])
    {
        [self takePhoto];
    }
    else if([title isEqualToString:@"Select photo"])
    {
        [self selectPhoto];
    }
}

-(void) selectPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.sender presentViewController:picker animated:YES completion:NULL];
}

- (void)takePhoto{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self.sender presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.image = info[UIImagePickerControllerEditedImage];
    
    //UIImage* chosenImage = info[UIImagePickerControllerEditedImage];
    //self.image = chosenImage;
    //image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
