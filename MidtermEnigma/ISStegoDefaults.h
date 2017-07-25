//
//  ISStegoDefaults.h
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-25.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <Foundation/Foundation.h>

extern int const INITIAL_SHIFT;

extern int const BYTES_PER_PIXEL;
extern int const BITS_PER_COMPONENT;

extern int const BYTES_OF_LENGTH;

extern NSString *const DATA_PREFIX;
extern NSString *const DATA_SUFFIX;

int SizeOfInfoLength();

int MinPixels();
