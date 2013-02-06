//
//  LDIFRecord.m
//  LDAPContacts
//
//  Created by Kevin Y. Kim on 2/5/13.
//  Copyright (c) 2013 Kevin Y. Kim. All rights reserved.
//

#import "LDIFRecord.h"

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

@end
