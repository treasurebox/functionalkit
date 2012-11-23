#import <SenTestingKit/SenTestingKit.h>
#import "FKMacros.h"
#import "FKFunction.h"
#import "NSArray+FunctionalKit.h"
#import "FKP2.h"
#import "NSString+FunctionalKit.h"
#import "NSArray+FunctionalKitBlocks.h"

@interface NSArrayExtensionsUnitTest : SenTestCase
@end

@implementation NSArrayExtensionsUnitTest

- (void)testCanGetTheHeadOfAnArray {
    NSArray *source = NSARRAY(@"1", @"2", @"3", @"4");
    STAssertEqualObjects(@"1", source.head, nil);
}

- (void)testCanGetTheTailOfAnArray {
    NSArray *source = NSARRAY(@"1", @"2", @"3", @"4");
    STAssertEqualObjects(NSARRAY(@"2", @"3", @"4"), source.tail, nil);
}

- (void)testCanGetASpanMatchingAPredicate {
    NSArray *source = NSARRAY(@"1", @"1", @"2", @"4");
    FKP2 *span = [source span:functionTS(self, isStringContainingOne:)];
    STAssertEqualObjects([FKP2 p2With_1:NSARRAY(@"1", @"1") _2:NSARRAY(@"2", @"4")], span, nil);
}

- (void)testCanTestAPredicateAgainstAllItems {
    NSArray *source = NSARRAY(@"1", @"1");
    BOOL allOnes = [source all:functionTS(self, isStringContainingOne:)];
    STAssertTrue(allOnes, nil);
}

- (void)testCanFilterUsingAPredicate {
    NSArray *source = NSARRAY(@"1", @"1", @"2", @"1");
    NSArray *onlyOnes = [source filter:functionTS(self, isStringContainingOne:)];
    STAssertEqualObjects(NSARRAY(@"1", @"1", @"1"), onlyOnes, nil);
}

- (void)testCanGroupItemsUsingAKeyFunctionIntoADictionary {
    NSArray *source = NSARRAY(@"1", @"1", @"2", @"1", @"3", @"3", @"4");
    NSDictionary *grouped = [source groupByKey:functionS(description)];
    STAssertEqualObjects(NSDICT(NSARRAY(@"1", @"1", @"1"), @"1", NSARRAY(@"2"), @"2", NSARRAY(@"3", @"3"), @"3", NSARRAY(@"4"), @"4"), grouped, nil);
}

- (void)testCanMapAFunctionAcrossAnArray {
	STAssertEqualObjects([NSARRAY(@"test") map:functionS(uppercaseString)], NSARRAY(@"TEST"), nil); 
}

- (void)testCanCreateANewArrayByConcatenatingAnotherOne {
    NSArray *source = NSARRAY(NSARRAY(@"1", @"2"), NSARRAY(@"3", @"4"));
    STAssertEqualObjects(NSARRAY(@"1", @"2", @"3", @"4"), [NSArray concat:source], nil);     
}

- (void)testConcatFailsOnNonArray {
    NSArray *source = NSARRAY(NSARRAY(@"1", @"2"), @"3");
    @try {
        [NSArray concat:source];
        STFail(@"Expected concat to fail with no-array argument", nil);
    }
    @catch (NSException * e) {
        // expected
    }
}

- (void)testCanLiftAFunctionIntoAnArray {
    NSArray *array = NSARRAY(@"a", @"b", @"c");
    id <FKFunction> liftedF = [NSArray liftFunction:functionS(uppercaseString)];
    STAssertEqualObjects(NSARRAY(@"A", @"B", @"C"), [liftedF :array], nil);
}

- (void)testCanIntersperseAnObjectWithinAnArray {
    NSArray *array = NSARRAY(@"A", @"B", @"C");
    STAssertEqualObjects(NSARRAY(@"A", @",", @"B", @",", @"C"), [array intersperse:@","], nil);
}

- (void)testCanFoldAcrossAnArray {
    NSArray *array = NSARRAY(@"A", @"B", @"C");
    STAssertEqualObjects(@"ABC", [array foldLeft:@"" f:[NSString concatF]], nil);
}

- (void)testCanReverseAnArray {
    NSArray *array = NSARRAY(@"A", @"B", @"C");
    STAssertEqualObjects(NSARRAY(@"C", @"B", @"A"), [array reverse], nil);
}

- (void)testCanUniquifyAnArray {
    NSArray *array = NSARRAY(@"A", @"B", @"C", @"C", @"A", @"A", @"B");
    STAssertEqualObjects(NSARRAY(@"A", @"B", @"C"), [array unique], nil);
}

- (void)testAnyReturnsTrue {
    NSArray *a = @[@1,@NO,@2];
    STAssertTrue([a any:functionS(boolValue)], nil);
    a = @[@NO,@NO,@NO,@1];
    STAssertTrue([a any:functionS(boolValue)], nil);
    a = @[@2,@1,@5,@1];
    STAssertTrue([a any:functionS(boolValue)], nil);
}

- (void)testAnyReturnsFalse {
    NSArray *array = @[@NO, @NO, @NO];
    STAssertFalse([array any:functionS(boolValue)], @"array %@ should return false");
}

- (void)testDropKeepsFalseEvaluations {
    NSArray *a = @[@1,@NO,@2];
    STAssertEqualObjects(@[@NO], [a drop:functionS(boolValue)], nil);
}

- (void)testDropReturnsEmpty {
    NSArray *a = @[@1,@2,@3];
    STAssertEqualObjects(@[], [a drop:functionS(boolValue)], nil);
}

- (void)testTakeTooMany {
    NSArray *a = @[@1,@2,@3];
    STAssertEquals(3U, [[a take:4] count], nil);
}

- (void)testTakeReturnsCorrectSizedArray {
    NSArray *a = @[@1,@2,@3];
    STAssertEquals(0U, [[a take:0] count], nil);
    STAssertEquals(1U, [[a take:1] count], nil);
    STAssertEquals(2U, [[a take:2] count], nil);
    STAssertEquals(3U, [[a take:3] count], nil);
}

- (void)testTakeFromEmptyArray {
    NSArray *a = @[];
    STAssertEquals(0U, [[a take:42] count], nil);
}

- (BOOL)isStringContainingOne:(id)string {
    return [string isEqual:@"1"];
}

#pragma mark Block Tests

- (void)testCanMapABlockAcrossAnArray {
    STAssertEqualObjects([@[@"test"] fkMapWithBlock:^id(id item) {return [item uppercaseString];}], @[@"TEST"], nil);
}

- (void)testCanMapIndexABlockAcrossAnArray {
    NSArray *actResult = [@[@"test", @"test"] fkMapIndexWithBlock:^id(NSUInteger index, id item) {
        return [item stringByAppendingFormat:@"%d", index];
    }];
    STAssertEqualObjects(actResult, NSARRAY(@"test0", @"test1"), nil);
}

- (void)testCanBlockFilterAnArray {
    NSArray *baseArray = @[@"apple", @"banana", @"apricot", @"pear"];
    NSArray *filteredResult = [baseArray fkFilterWitbBlock:^BOOL(id item) {
        return [item hasPrefix:@"a"];
    }];
    STAssertEqualObjects(filteredResult, NSARRAY(@"apple", @"apricot"), nil);
}

- (void)testCanBlockRejectAnArray {
    NSArray *baseArray = @[@"apple", @"banana", @"apricot", @"pear"];
    NSArray *filteredResult = [baseArray fkRejectWithBlock:^BOOL(id item) {
        return [item hasPrefix:@"a"];
    }];
    STAssertEqualObjects(filteredResult, NSARRAY(@"banana", @"pear"), nil);
}

@end
