//
//  LDIFRecordUtils.h
//  LDAPContacts
//
//  Created by Kevin Y. Kim on 2/1/13.
//  Copyright (c) 2013 Kevin Y. Kim. All rights reserved.
//

#import "LDIFRecord.h"

@interface LDIFRecord (ABPersonUtils)

- (void)setValue:(CFTypeRef)value forProperty:(ABPropertyID)property ofRecord:(ABRecordRef)record;
- (void)setStringValue:(NSString *)value forProperty:(ABPropertyID)property ofRecord:(ABRecordRef)record;
- (void)setStringValue:(NSString *)value andLabel:(CFStringRef)label forMultiValueRef:(ABMutableMultiValueRef)multi;
- (void)logError:(CFErrorRef)error;

@end
