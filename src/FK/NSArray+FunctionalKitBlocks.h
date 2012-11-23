//
//  NSArray+FunctionalKitBlocks.h
//  functionalkit
//
//  Created by Kim Hunter on 24/11/12.
//
//

#import <Foundation/Foundation.h>


@interface NSArray (FunctionalKitBlocks)
- (NSArray *)fkMapWithBlock:(id (^)(id item))mapBlock;
- (NSArray *)fkMapIndexWithBlock:(id (^)(NSUInteger index, id item))mapBlock;
- (NSArray *)fkFilterWitbBlock:(BOOL (^)(id item))filterBlock;
- (NSArray *)fkRejectWithBlock:(BOOL (^)(id item))rejectBlock;

@end
