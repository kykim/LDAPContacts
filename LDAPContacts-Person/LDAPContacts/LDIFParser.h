//
//  LDIFParser.h
//  LDAPContacts
//
//  Created by Kevin Y. Kim on 2/5/13.
//  Copyright (c) 2013 Kevin Y. Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDIFParser : NSObject

@property (strong, nonatomic) NSString *path;
- (id)initWithLDIF:(NSString *)path;
- (NSArray *)parse;
- (NSArray *)collate:(NSArray *)records;

@end
