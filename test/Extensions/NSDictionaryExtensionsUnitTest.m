#import <SenTestingKit/SenTestingKit.h>
#import "FKMacros.h"
#import "FKFunction.h"
#import "NSDictionary+FunctionalKit.h"
#import "FKP2.h"

@interface NSDictionaryExtensions : SenTestCase
@end

@implementation NSDictionaryExtensions

- (void)testDictionaryToArray {
    NSDictionary *dict = NSDICT(@"v1", @"k1", @"v2", @"k2");
    STAssertEqualObjects(NSARRAY(pair2(@"k2", @"v2"), pair2(@"k1", @"v1")), [dict toArray], nil);
}

- (void)testAskingForANonExistentValueReturnsANone {
    NSDictionary *dict = NSDICT(@"value", @"key");
    STAssertTrue([[dict maybeObjectForKey:@"not_there"] isNone] , nil);
}

- (void)testAskingForANonExistentValueReturnsASomeWithTheValue {
    NSDictionary *dict = NSDICT(@"value", @"key");
    FKOption *maybeValue = [dict maybeObjectForKey:@"key"];
    STAssertTrue([maybeValue isSome] , nil);
    STAssertEqualObjects(@"value", maybeValue.some, nil);
}

@end