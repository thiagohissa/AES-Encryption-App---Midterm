//
//  ViewController.m
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-24.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import "NSData+MyEncryption.h"



@interface ViewController () <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mainTextField;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextView *resultTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"WebViewContent2" ofType:@"html"];
    NSURL *htmlURL = [[NSURL alloc] initFileURLWithPath:htmlPath];
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:htmlURL];
    
    [self.myWebView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[htmlURL URLByDeletingLastPathComponent]];
    
    
    CALayer *bottomBorder1 = [CALayer layer];
    bottomBorder1.frame = CGRectMake(0.0f, self.mainTextField.frame.size.height - 1, self.mainTextField.frame.size.width, 0.3f);
    bottomBorder1.backgroundColor = [UIColor whiteColor].CGColor;
    [self.mainTextField.layer addSublayer:bottomBorder1];
    
    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.frame = CGRectMake(0.0f, self.keyTextField.frame.size.height - 1, self.keyTextField.frame.size.width, 0.3f);
    bottomBorder2.backgroundColor = [UIColor whiteColor].CGColor;
    [self.keyTextField.layer addSublayer:bottomBorder2];
    
    UIColor *color = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    self.mainTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Insert Text Here" attributes:@{NSForegroundColorAttributeName: color}];
    self.keyTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Key" attributes:@{NSForegroundColorAttributeName: color}];
}



- (IBAction)encryptionButton:(id)sender {
    Model *model = [[Model alloc]init];
    NSData *data = [model encryptString:self.mainTextField.text withKey:self.keyTextField.text];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [data base64EncodedStringWithOptions:0];
    self.resultTextField.text = base64Encoded;
   
}


- (IBAction)decriptionButton:(id)sender {
    Model *model = [[Model alloc]init];
    NSString *originalString = [NSString stringWithFormat:@"%@", self.mainTextField.text];
    NSData *data = [NSData dataFromBase64String:originalString];
    self.resultTextField.text = [model decryptData:data withKey:self.keyTextField.text];
}






- (IBAction)dismissViewButton:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}







#pragma Alert Buttons

- (IBAction)iMessageButton:(id)sender {
 
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Send"
                                                                  message:@"Your encrypted message was copied. Which service would you like to use ?"
                                                           preferredStyle:UIAlertControllerStyleAlert];
    // Launch iMessage App
    UIAlertAction* iMessageButton = [UIAlertAction actionWithTitle:@"iMessage"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
    {
        NSString *stringURL = @"sms:";
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        UIPasteboard *pb = [UIPasteboard generalPasteboard];
        [pb setString:self.resultTextField.text];
    }];
    
  
    
    
    
    
    
    
    // Launch Email App
    UIAlertAction* emailButton = [UIAlertAction actionWithTitle:@"Email"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
    {
        MFMailComposeViewController *composeVC = [[MFMailComposeViewController alloc] init];
        composeVC.mailComposeDelegate = self;
        
        if (![MFMailComposeViewController canSendMail]) {
            NSLog(@"Mail services are not available.");
            return;
        }
        
        // Configure the fields of the interface.
        [composeVC setToRecipients:@[@"address@example.com"]];
        [composeVC setSubject:@""];
        [composeVC setMessageBody:self.resultTextField.text isHTML:NO];
        
        // Present the view controller modally.
        [self presentViewController:composeVC animated:YES completion:nil];
        
    }];
    
    
    
    
    
    
    
    // Launch Whatsapp App
    UIAlertAction* whatsAppButton = [UIAlertAction actionWithTitle:@"WhatsApp"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
    {
        NSURL *whatsappURL = [NSURL URLWithString:[NSString stringWithFormat:@"whatsapp://send?text=%@",self.resultTextField.text]];
        
        // Handling Whatsapp error:
        if (![[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
            
            UIAlertController * whatsappalert =[UIAlertController alertControllerWithTitle:@"Error"
                message:@"Unable to open Whatsapp"
                preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* whatsappError = [UIAlertAction actionWithTitle:@"Ok"style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
            {
                
            }];
            [whatsappalert addAction:whatsappError];
            [self presentViewController:whatsappalert animated:YES completion:nil];
        }
        else{
            [[UIApplication sharedApplication] openURL:whatsappURL options:@{} completionHandler:nil];
        }
        
    }];
    
    
    
    // Cancel Button
    UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    
    [alert addAction:iMessageButton];
    [alert addAction:emailButton];
    [alert addAction:whatsAppButton];
    [alert addAction:cancelButton];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}





@end
