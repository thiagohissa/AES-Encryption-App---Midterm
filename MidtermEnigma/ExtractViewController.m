//
//  ExtractViewController.m
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-25.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "ExtractViewController.h"
#import "ISUtils.h"
#import "ISSteganographer.h"

@interface ExtractViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation ExtractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureStegoObject];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"WebViewContent2" ofType:@"html"];
    NSURL *htmlURL = [[NSURL alloc] initFileURLWithPath:htmlPath];
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:htmlURL];
    
    [self.myWebView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[htmlURL URLByDeletingLastPathComponent]];
}

- (void)configureStegoObject {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:STEGO_IMAGE_NAME];
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    if (image) {
        self.imageView.image = image;
    } else {
        [ISUtils showMessage:@"No Stego-object!"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}





- (IBAction)cameraButton:(id)sender {
    [self showImagePickerViewController];
}








- (IBAction)extract {
    [ISSteganographer dataFromImage:self.imageView.image
                    completionBlock:^(NSData *data, NSError *error) {
                        if (error) {
                            [ISUtils showMessage:[NSString stringWithFormat:@"%@", error]];
                        } else {
                            [self showData:data];
                        }
                    }];
}

- (void)showData:(NSData *)data {
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    
    [ISUtils showMessage:string];
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

