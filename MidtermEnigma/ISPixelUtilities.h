//
//  ISPixelUtilities.h
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-25.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ISPixelColor) {
    ISPixelColorRed,
    ISPixelColorGreen,
    ISPixelColorBlue
};

UInt32 Color(UInt32 x, int shift);

UInt32 NewPixel(UInt32 pixel, UInt32 shiftedBits, int shift);

UInt32 AddBits(UInt32 number1, UInt32 number2, int shift);

ISPixelColor ColorToStep(UInt32 pixel);
