//
//  ISStegoDecoder.h
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-25.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISStegoDecoder : NSObject

- (NSData *)decodeStegoImage:(id)image
                       error:(NSError **)error;

@end
