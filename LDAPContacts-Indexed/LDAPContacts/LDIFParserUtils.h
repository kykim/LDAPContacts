//
//  LDIFParserUtils.h
//  LDAPContacts
//
//  Created by Kevin Y. Kim on 2/1/13.
//  Copyright (c) 2013 Kevin Y. Kim. All rights reserved.
//

#import "LDIFParser.h"

@interface LDIFParser (CollationUtils)

- (NSMutableArray *)arrayForCollationIndex;
- (void)collateRecords:(NSArray *)records into:(NSMutableArray *)collatedArrays withSelector:(SEL)selector;
- (NSArray *)sortCollatedRecords:(NSArray *)collatedArrays withSelector:(SEL)selector;

@end
