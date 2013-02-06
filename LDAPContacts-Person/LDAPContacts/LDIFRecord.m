//
//  LDIFRecord.m
//  LDAPContacts
//
//  Created by Kevin Y. Kim on 2/5/13.
//  Copyright (c) 2013 Kevin Y. Kim. All rights reserved.
//

#import "LDIFRecord.h"
#import "LDIFRecordUtils.h"

@implementation LDIFRecord

- (id)initWithString:(NSString *)recordString
{
    self = [super init];
    if (self) {
        _recordString = recordString;
        [self parseRecordString];
    }
    return self;
}

- (void)parseRecordString
{
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    NSArray *records = [_recordString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for (NSString *record in records) {
        if ([record length] == 0) {
            continue;
        }
        NSArray *kv = [record componentsSeparatedByString:@": "];
        [results setValue:[kv objectAtIndex:1] forKey:[kv objectAtIndex:0]];
    }
    _records = results;
    return;
}

- (NSString *)displayString
{
    return [NSString stringWithFormat:@"%@, %@", [_records valueForKey:@"sn"], [_records valueForKey:@"givenName"]];
}

- (ABRecordRef)abPerson
{
    ABRecordRef aRecord = ABPersonCreate();
    
    [self setStringValue:[_records valueForKey:@"givenName"] forProperty:kABPersonFirstNameProperty ofRecord:aRecord];
    [self setStringValue:[_records valueForKey:@"sn"] forProperty:kABPersonLastNameProperty ofRecord:aRecord];
    [self setStringValue:[_records valueForKey:@"title"] forProperty:kABPersonJobTitleProperty ofRecord:aRecord];
    [self setStringValue:[_records valueForKey:@"ou"] forProperty:kABPersonDepartmentProperty ofRecord:aRecord];
    [self setStringValue:[_records valueForKey:@"description"] forProperty:kABPersonNoteProperty ofRecord:aRecord];
    
    [self setEmailForRecord:aRecord];
    [self setPhonesForRecord:aRecord];
    [self setAddressForRecord:aRecord];
    
    return aRecord;
}

- (void)setEmailForRecord:(ABRecordRef)record
{
    ABMutableMultiValueRef emails = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    [self setStringValue:[_records valueForKey:@"mail"] andLabel:kABWorkLabel forMultiValueRef:emails];
    [self setValue:emails forProperty:kABPersonEmailProperty ofRecord:record];
    CFRelease(emails);
    return;
}

- (void)setPhonesForRecord:(ABRecordRef)record
{
    ABMutableMultiValueRef phones = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    [self setStringValue:[_records valueForKey:@"telephoneNumber"] andLabel:kABPersonPhoneMainLabel forMultiValueRef:phones];
    [self setStringValue:[_records valueForKey:@"mobile"] andLabel:kABPersonPhoneMobileLabel forMultiValueRef:phones];
    [self setStringValue:[_records valueForKey:@"homePhone"] andLabel:kABHomeLabel forMultiValueRef:phones];
    [self setStringValue:[_records valueForKey:@"facsimileTelephoneNumber"] andLabel:kABPersonPhoneWorkFAXLabel forMultiValueRef:phones];
    [self setStringValue:[_records valueForKey:@"pager"] andLabel:kABPersonPhonePagerLabel forMultiValueRef:phones];
    [self setValue:phones forProperty:kABPersonPhoneProperty ofRecord:record];
    CFRelease(phones);
}

- (void)setAddressForRecord:(ABRecordRef)record
{
    // Address
    NSArray *ldifAddress = [[_records valueForKey:@"postalAddress"] componentsSeparatedByString:@"$"];
    NSDictionary *addressDictionary = @{ (__bridge NSString *)kABPersonAddressStreetKey  : [ldifAddress objectAtIndex:0],
                                         (__bridge NSString *)kABPersonAddressCityKey    : [ldifAddress objectAtIndex:1],
                                         (__bridge NSString *)kABPersonAddressStateKey   : @"CA",
                                         (__bridge NSString *)kABPersonAddressCountryKey : @"USA" };
    ABMutableMultiValueRef address = ABMultiValueCreateMutable(kABDictionaryPropertyType);
    
    BOOL success = ABMultiValueAddValueAndLabel(address, (__bridge_retained CFDictionaryRef)addressDictionary, kABWorkLabel, NULL);
    if (success)
        [self setValue:address forProperty:kABPersonAddressProperty ofRecord:record];
    return;
}

@end
