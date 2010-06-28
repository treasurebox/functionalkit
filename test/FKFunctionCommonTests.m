#import <SenTestingKit/SenTestingKit.h>
#import "FKFunction+Common.h"

@interface FKFunctionCommonTests : SenTestCase
@end

@implementation FKFunctionCommonTests

- (void)testIdentity {
	STAssertEqualObjects(@"54", [[FKFunction identity] :@"54"], nil);
}

- (void)testConst {
	STAssertEqualObjects(@"54", [[FKFunction const:@"54"] :@"wat"], nil);
}

@end
