#import <SenTestingKit/SenTestingKit.h>
#import "FKP1.h"
#import "FKFunction.h"

@interface SupplierP1Test: SenTestCase {
    NSObject *o1;
    NSObject *o2;
    int invokeCount;
}
@end

@implementation SupplierP1Test

- (void)setUp {
    invokeCount = 0;
}

- (NSString *)some:(NSString *)a {
    invokeCount++;
    return [a uppercaseString];
}

- (void)testIt {
    FKP1 *supplier = [FKP1 supplierWithFunction:functionTS(self,some:) argument:@"a"];
    id one = supplier._1;
    id two = supplier._1;
    STAssertEqualObjects(one,@"A", nil);
    STAssertEqualObjects(two,one, nil);
    STAssertTrue(invokeCount == 2, nil);
}

@end
