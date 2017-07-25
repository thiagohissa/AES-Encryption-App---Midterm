//
//  ISStegoUtilities.h
//  MidtermEnigma
//
//  Created by Thiago Hissa on 2017-07-25.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSInteger, ISStegoErrorDomainCode) {
    ISStegoErrorDomainCodeNotDefined,
    ISStegoErrorDomainCodeDataTooBig,
    ISStegoErrorDomainCodeImageTooSmall,
    ISStegoErrorDomainCodeNoDataInImage
};

extern NSString *const ISStegoErrorDomain;

NSError *ErrorForDomainCode(ISStegoErrorDomainCode code);

BOOL Contains(NSString *string, NSString *substring);

NSString *Substring(NSString *string, NSString *prefix, NSString *suffix);

CGImageRef CGImageCreateWithImage(id image);

id Image(CGImageRef imageRef);
