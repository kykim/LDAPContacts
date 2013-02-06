//
//  LDIFParserUtils.m
//  LDAPContacts
//
//  Created by Kevin Y. Kim on 2/1/13.
//  Copyright (c) 2013 Kevin Y. Kim. All rights reserved.
//

#import "LDIFParserUtils.h"
#import "LDIFRecord.h"

@implementation LDIFParser (CollationUtils)

- (NSMutableArray *)arrayForCollationIndex
{
    NSMutableArray *array = [NSMutableArray array];
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    for (NSUInteger i = 0; i < [[collation sectionIndexTitles] count]; i++)
        [array addObject:[NSMutableArray array]];
    return array;
}

- (void)collateRecords:(NSArray *)records into:(NSMutableArray *)collatedArrays withSelector:(SEL)selector
{
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    for (LDIFRecord *record in records) {
        NSUInteger sectionNumber = [collation sectionForObject:record collationStringSelector:selector];
        [[collatedArrays objectAtIndex:sectionNumber] addObject:record];
    }
}

- (NSArray *)sortCollatedRecords:(NSArray *)collatedArrays withSelector:(SEL)selector
{
    NSMutableArray *sortedCollatedRecords = [NSMutableArray array];
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    for (NSMutableArray *array in collatedArrays) {
        NSArray *sortedSection = [collation sortedArrayFromArray:array collationStringSelector:selector];
        [sortedCollatedRecords addObject:sortedSection];
    }
    return sortedCollatedRecords;
}

@end
