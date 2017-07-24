//
//  Model.h
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-24.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface Model : NSObject
- (NSData*) encryptString:(NSString*)plaintext withKey:(NSString*)key;
- (NSString*) decryptData:(NSData*)ciphertext withKey:(NSString*)key;
@end
