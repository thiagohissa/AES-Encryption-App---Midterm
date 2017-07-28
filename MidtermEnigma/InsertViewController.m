//
//  InsertViewController.m
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-25.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "InsertViewController.h"
#import "ISUtils.h"
#import "ISSteganographer.h"

@interface InsertViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *exportOrSaveButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation InsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TextField Style:
    CALayer *bottomBorder1 = [CALayer layer];
    bottomBorder1.frame = CGRectMake(0.0f, self.textField.frame.size.height - 1, self.textField.frame.size.width, 0.3f);
    bottomBorder1.backgroundColor = [UIColor whiteColor].CGColor;
    [self.textField.layer addSublayer:bottomBorder1];
    
    UIColor *color = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Insert Text Here" attributes:@{NSForegroundColorAttributeName: color}];
    
    
    // Background Animation(GIF):
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"WebViewContent2" ofType:@"html"];
    NSURL *htmlURL = [[NSURL alloc] initFileURLWithPath:htmlPath];
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:htmlURL];
    [self.myWebView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[htmlURL URLByDeletingLastPathComponent]];
}



#pragma IBActions

- (IBAction)cameraButton:(id)sender {
    [self showImagePickerViewController];
}

- (IBAction)insertTextToImageButton:(id)sender {
    [self insert];
}

- (IBAction)dismissViewButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)exportSaveButton:(id)sender {
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Export"
                                                                  message:@"Image was copied."
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    
    // Send Button
    UIAlertAction *sendButton = [UIAlertAction actionWithTitle:@"iMessage" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *stringURL = @"sms:";
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        UIPasteboard *pb = [UIPasteboard generalPasteboard];
        [pb setImage:self.imageView.image];
    }];
    
    
    // Save Button
    UIAlertAction *saveButton = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
    }];
    
    // Cancel Button
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    
    
    [alert addAction:saveButton];
    [alert addAction:sendButton];
    [alert addAction:cancelButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}












- (void)insert {
    [self.textField resignFirstResponder];
    if (self.imageView.image && [self.textField.text length] > 0) {
        [ISSteganographer hideData:self.textField.text
                         withImage:self.imageView.image
                   completionBlock:^(UIImage *image, NSError *error) {
                       if (error) {
                           [ISUtils showMessage:[NSString stringWithFormat:@"%@", error]];
                       } else {
                           [self saveImage:image];
                       }
                   }];
    } else {
        [ISUtils showMessage:@"No image/text..."];
    }
}



- (void)saveImage:(UIImage *)image {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:STEGO_IMAGE_NAME];
    if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {
        [ISUtils showMessage:@"Done"];
        
        
        


        

        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
        // Do nothing
        });
    } else {
        [ISUtils showMessage:@"Error on saving Stego-object"];
    }
}






#pragma mark - ImagePickerViewController

- (void)showImagePickerViewController {
    UIImagePickerController *viewController = [[UIImagePickerController alloc] init];
    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!image) image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (image) {
        self.imageView.image = image;
    }
    self.exportOrSaveButton.hidden = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
