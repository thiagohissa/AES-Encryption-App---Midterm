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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mainTextField;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextView *resultTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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



@end
