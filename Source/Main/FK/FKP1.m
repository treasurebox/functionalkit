#import "FKP1.h"
#import <objc/runtime.h>

@interface SupplierP1 : FKP1 {
    FKFunction *f;
    id argument;
}

- (SupplierP1 *)initWithFunction:(FKFunction *)fu argument:(id)a;
@end

@implementation SupplierP1

- (void)dealloc {
    [f release];
    [argument release];
    [super dealloc];
}

- (SupplierP1 *)initWithFunction:(FKFunction *)fu argument:(id)a {
    if ((self = [super init])) {
        f = [fu retain];
        argument = [a retain];
    }
    
    return self;
}

- (id)_1 {
    return [f :argument];
}

@end

@implementation FKP1

@synthesize _1;

+ (FKP1 *)supplierWithFunction:(FKFunction *)f argument:(id)arg {
    return [[[SupplierP1 alloc] initWithFunction:f argument:arg] autorelease];
}

- (void)dealloc {
    [_1 release];
    [super dealloc];
}

- (id)initWith_1:(id)new_1 {
    if (self = [super init]) {
        _1 = [new_1 retain];
    }
    return self;
}

+ (FKP1 *)p1With_1:(id)_1 {
    return [[[FKP1 alloc] initWith_1:_1] autorelease];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<%s: _1=%@>", class_getName([self class]), _1];
}

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    if (object == nil || ![[object class] isEqual:[self class]]) {
        return NO;
    } else {
        FKP1 *other = (FKP1 *)object;
		return [_1 isEqual:other._1];
    }
}

- (NSUInteger)hash {
    return [_1 hash];
}

#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
	return [self retain];
}
@end
