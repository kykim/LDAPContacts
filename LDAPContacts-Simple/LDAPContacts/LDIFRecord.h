//
//  LDIFRecord.h
//  LDAPContacts
//
//  Created by Kevin Y. Kim on 2/5/13.
//  Copyright (c) 2013 Kevin Y. Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDIFRecord : NSObject

@property (strong, nonatomic) NSString *recordString;
@property (strong, nonatomic) NSDictionary *records;

- (id)initWithString:(NSString *)recordString;
- (void)parseRecordString;
- (NSString *)displayString;

@end
