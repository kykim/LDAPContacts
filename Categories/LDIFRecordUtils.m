//
//  LDIFRecordUtils.m
//  LDAPContacts
//
//  Created by Kevin Y. Kim on 2/1/13.
//  Copyright (c) 2013 Kevin Y. Kim. All rights reserved.
//

#import "LDIFRecordUtils.h"

@implementation LDIFRecord (ABPersonUtils)

- (void)setValue:(CFTypeRef)value forProperty:(ABPropertyID)property ofRecord:(ABRecordRef)record
{
    CFErrorRef anError = NULL;
    BOOL success = ABRecordSetValue(record, property, value, &anError);
    if (!success)
        [self logError:anError];
    if (anError)
        CFRelease(anError);
    return;
}

- (void)setStringValue:(NSString *)value forProperty:(ABPropertyID)property ofRecord:(ABRecordRef)record
{
    CFStringRef cfValue = CFStringCreateCopy(NULL, (__bridge CFStringRef)value);
    [self setValue:cfValue forProperty:property ofRecord:record];
    return;
}

- (void)setStringValue:(NSString *)value andLabel:(CFStringRef)label forMultiValueRef:(ABMutableMultiValueRef)multi
{
    CFStringRef cfValue = CFStringCreateCopy(NULL, (__bridge CFStringRef)value);
    BOOL success = ABMultiValueAddValueAndLabel(multi, cfValue, label, NULL);
    if (!success)
        NSLog(@"Error Setting MultiValue Property");
    return;
}

- (void)logError:(CFErrorRef)error
{
    CFDictionaryRef userInfo = CFErrorCopyUserInfo(error);
    CFStringRef errorDesc = CFDictionaryGetValue(userInfo, kCFErrorDescriptionKey);
    NSLog(@"Error: %@", (__bridge NSString *)errorDesc);
    CFRelease(errorDesc);
    CFRelease(userInfo);
}

@end
