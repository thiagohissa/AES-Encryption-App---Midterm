//
//  Model.m
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-24.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "Model.h"
#import "NSData+MyEncryption.h"

@implementation Model

- (NSData*) encryptString:(NSString*)plaintext withKey:(NSString*)key {
    return [[plaintext dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:key];
}

- (NSString*) decryptData:(NSData*)ciphertext withKey:(NSString*)key {
    return [[NSString alloc] initWithData:[ciphertext AES256DecryptWithKey:key]
                                  encoding:NSUTF8StringEncoding];
}

@end
