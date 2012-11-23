//
//  NSArray+FunctionalKitBlocks.m
//  functionalkit
//
//  Created by Kim Hunter on 24/11/12.
//
//

#import "NSArray+FunctionalKitBlocks.h"

@implementation NSArray (FunctionalKitBlocks)

- (NSArray *)fkMapWithBlock:(id (^)(id))mapBlock
{
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (id item in self) {
        [newArray addObject:mapBlock(item)];
    }
    return [[newArray copy] autorelease];
}


- (NSArray *)fkMapIndexWithBlock:(id (^)(NSUInteger, id))mapIndexBlock
{
    NSArray *result = nil;
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:[self count]];
    NSUInteger size = [self count];
    
    for (NSUInteger i=0; i < size; ++i)
    {
        [newArray addObject:mapIndexBlock(i, [self objectAtIndex:i])];
    }
    result = [[newArray copy] autorelease];
    [newArray release];
    return result;
}

- (NSArray *)fkFilterWitbBlock:(BOOL (^)(id))filterBlock {
    NSArray *result = nil;
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:[self count]/2];
    for (id item in self) {
        if (filterBlock(item)) {
            [newArray addObject:item];
        }
    }
    result = [[newArray copy] autorelease];
    [newArray release];
    return result;
}

- (NSArray *)fkRejectWithBlock:(BOOL (^)(id))rejectBlock
{
    NSArray *result = nil;
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:[self count]/2];
    for (id item in self) {
        if (!rejectBlock(item)) {
            [newArray addObject:item];
        }
    }
    result = [[newArray copy] autorelease];
    [newArray release];
    return result;
}

@end
