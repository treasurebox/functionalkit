#import <SenTestingKit/SenTestingKit.h>
#import "FKNewTypeArc.h"

NEWTYPEARC(Age_arc, NSString, age);
NEWTYPEARC(Name_arc, NSString, name);
NEWTYPE2ARC(Person_arc, Age_arc, age, Name_arc, name);
NEWTYPE3ARC(Position_arc, Person_arc, occupier, NSString, title, NSDate, started);

NEWTYPE2ARC(Simple2_arc, NSString, a, NSString, b);
NEWTYPE3ARC(Simple3_arc, NSString, a, NSString, b, NSString, c); 

@interface FKNewtypeArcTests : SenTestCase
@end

@implementation FKNewtypeArcTests

- (void)testArcOn
{
	STAssertTrue(__has_feature(objc_arc), @"ARC should be on");
}

- (void)testTypes {
	Age_arc *age = [Age_arc age:@"54"];
	Name_arc *name = [Name_arc name:@"Nick"];
	Person_arc *nick = [Person_arc age:age name:name];
	Position_arc *p = [Position_arc occupier:nick title:@"Dev" started:[NSDate date]];
	STAssertEqualObjects(age.age, @"54", nil);
	STAssertEqualObjects(nick.name.name, @"Nick", nil);
	STAssertEqualObjects(p.title, @"Dev", nil);
}

- (void)testValidArrayCreation {
	id fromValid = NSArrayToAge_arc([NSArray arrayWithObject:@"54"]);
    
	STAssertTrue([fromValid isSome], nil);
	STAssertEqualObjects([fromValid some], [Age_arc age:@"54"], nil);
	
	id fromValid2 = NSArrayToPerson_arc([NSArray arrayWithObjects:[Age_arc age:@"54"], [Name_arc name:@"Nick"], nil]);
	STAssertTrue([fromValid2 isSome], nil);
	STAssertEqualObjects([fromValid2 some], [Person_arc age:[Age_arc age:@"54"] name:[Name_arc name:@"Nick"]], nil);
	
	id fromValid3 = NSArrayToSimple3_arc([NSArray arrayWithObjects:@"a", @"b", @"c",nil]);
	STAssertTrue([fromValid3 isSome], nil);
	STAssertEqualObjects([fromValid3 some], [Simple3_arc a:@"a" b:@"b" c:@"c"], nil);
}

- (void)testWrongSizeArrayCreation {

	id fromEmpty = NSArrayToAge_arc(EMPTY_ARRAY);
	STAssertTrue([fromEmpty isKindOfClass:[FKOption class]],nil);
	STAssertTrue([fromEmpty isNone], nil);
	
	id fromTooBig = NSArrayToAge_arc(NSARRAY(@"54", @"55"));
	STAssertTrue([fromTooBig isKindOfClass:[FKOption class]],nil);
	STAssertTrue([fromTooBig isNone], nil);
}

- (void)testWrongTypeArrayCreation {
	id fromWrongType = NSArrayToAge_arc(NSARRAY([NSNumber numberWithInt:54]));
	STAssertTrue([fromWrongType isKindOfClass:[FKOption class]],nil);
	STAssertTrue([fromWrongType isNone], nil);
}

- (void)testValidDictionaryCreation {
	FKOption *result = NSDictionaryToAge_arc(NSDICT(@"54", @"age"));
	STAssertTrue(result.isSome, nil);
	STAssertEqualObjects(result.some,[Age_arc age:@"54"], nil);
	
	result = NSDictionaryToSimple2_arc(NSDICT(@"bval", @"b", @"aval", @"a"));
	STAssertTrue([result isSome], nil);
	STAssertEqualObjects([result some], [Simple2_arc a:@"aval" b:@"bval"], nil);
	
	result = NSDictionaryToSimple3_arc(NSDICT(@"bval", @"b", @"aval", @"a", @"cval", @"c"));
	STAssertTrue([result isSome], nil);
	STAssertEqualObjects([result some], [Simple3_arc a:@"aval" b:@"bval" c:@"cval"], nil);
}

- (void)testInvalidDictionaryCreation {
	FKOption *result = NSDictionaryToAge_arc(NSDICT(@"54", @"ages"));
	STAssertTrue(result.isNone, nil);
}
@end

