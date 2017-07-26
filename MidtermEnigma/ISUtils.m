//
//  ISUtils.m
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-25.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "ISUtils.h"

NSString *const STEGO_IMAGE_NAME = @"STEGO_IMAGE.png";

@implementation ISUtils

+ (void)showMessage:(NSString*)message {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(showMessage:)
                               withObject:message
                            waitUntilDone:NO];
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
    alertView = nil;
}

@end
