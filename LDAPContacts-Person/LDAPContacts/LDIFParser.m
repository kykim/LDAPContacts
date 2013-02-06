//
//  LDIFParser.m
//  LDAPContacts
//
//  Created by Kevin Y. Kim on 2/5/13.
//  Copyright (c) 2013 Kevin Y. Kim. All rights reserved.
//

#import "LDIFParser.h"
#import "LDIFRecord.h"
#import	"LDIFParserUtils.h"

@implementation LDIFParser

- (id)initWithLDIF:(NSString *)path
{
    self = [super init];
    if (self) {
        _path = path;
    }
    return self;
}

- (NSArray *)parse
{
    NSMutableArray *ldifRecords = [NSMutableArray array];
    NSString *ldifData = [NSString stringWithContentsOfFile:_path encoding:NSUTF8StringEncoding error:nil];
    NSArray *records = [ldifData componentsSeparatedByString:@"\n\n"];
    
    for (NSInteger i = 1; i < [records count]; i++) {
        NSString *record = [records objectAtIndex:i];
        LDIFRecord *ldifRecord = [[LDIFRecord alloc] initWithString:record];
        [ldifRecords addObject:ldifRecord];
    }
    
    return [self collate:ldifRecords];
}

- (NSArray *)collate:(NSArray *)records
{
    NSMutableArray *sectionArrays = [self arrayForCollationIndex];
    [self collateRecords:records into:sectionArrays withSelector:@selector(displayString)];
    return [self sortCollatedRecords:sectionArrays withSelector:@selector(displayString)];
}

@end
