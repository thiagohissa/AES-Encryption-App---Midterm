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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation InsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"WebViewContent2" ofType:@"html"];
    NSURL *htmlURL = [[NSURL alloc] initFileURLWithPath:htmlPath];
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:htmlURL];
    
    [self.myWebView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[htmlURL URLByDeletingLastPathComponent]];
}


- (IBAction)cameraButton:(id)sender {
    [self showImagePickerViewController];
}

- (IBAction)insertTextToImageButton:(id)sender {
    [self insert];
}


- (IBAction)dismissViewButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
            [self.navigationController popToRootViewControllerAnimated:YES];
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
