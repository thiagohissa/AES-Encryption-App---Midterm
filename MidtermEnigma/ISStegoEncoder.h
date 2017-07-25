//
//  ISStegoEncoder.h
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-25.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISStegoEncoder : NSObject

- (id)stegoImageForImage:(id)image
                    data:(id)data
                   error:(NSError **)error;

@end
