//
//  FirstViewController.m
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-24.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "FirstViewController.h"
#import "ISUtils.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonExtract;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"WebViewContent" ofType:@"html"];
    NSURL *htmlURL = [[NSURL alloc] initFileURLWithPath:htmlPath];
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:htmlURL];
    
    [self.myWebview loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[htmlURL URLByDeletingLastPathComponent]];
    
  
    
}



- (IBAction)decideWhichViewButton:(id)sender {
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Image"
                                                                  message:@"Choose if you want to:"
                                                           preferredStyle:UIAlertControllerStyleAlert];
    // Launch iMessage App
    UIAlertAction* insertView = [UIAlertAction actionWithTitle:@"Insert Message" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [self performSegueWithIdentifier:@"showInsert" sender:sender];
   }];
    
    
    
    // Launch Email App
    UIAlertAction* extractView = [UIAlertAction actionWithTitle:@"Reveal Message" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [self performSegueWithIdentifier:@"showExtract" sender:sender];
     }];
    
   
    [alert addAction:insertView];
    [alert addAction:extractView];
    
    [self presentViewController:alert animated:YES completion:nil];
 
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.buttonExtract setEnabled:[self hasStegoObject]];
}

- (BOOL)hasStegoObject {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:STEGO_IMAGE_NAME];
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    return image ? YES : NO;
}



@end
