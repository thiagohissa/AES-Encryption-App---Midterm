//
//  ImagePickerViewController.m
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-25.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "ImagePickerViewController.h"

@interface ImagePickerViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *testImage;

@end

@implementation ImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"WebViewContent2" ofType:@"html"];
    NSURL *htmlURL = [[NSURL alloc] initFileURLWithPath:htmlPath];
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:htmlURL];
    
    [self.myWebView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[htmlURL URLByDeletingLastPathComponent]];
    
    
  //  4iuSo2RKp/oQyBdn4Yh8qg==
  // First Hash: 106102874007552  (for .image)
  // Second Hash: 106102873949952 (for .image)
  // Third Hash: 106102873959792  (for .image)
    
  // Hash for Image : 140323078550192
    
    
    NSUInteger hashInt = [self.testImage.image hash];
    NSLog(@"Hash : %lu",(unsigned long)hashInt);
}






- (IBAction)dismissViewButton:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

@end
