#import <Foundation/Foundation.h>
#import "FK/FKFunction.h"

typedef void (*fkEffect)(id);

#define effectS(s) [FKEffect effectFromSelector:@selector(s)]
#define effectTS(t, s) [FKEffect effectFromSelector:@selector(s) target:t]
#define effectSA(s, a) [FKEffect effectFromSelector:@selector(s) withArgument:a]

@protocol FKEffect <NSObject>
- (oneway void)e:(id)arg;
@end

@interface FKEffect : NSObject
+ (id <FKEffect>)comap:(id <FKEffect>)effect :(id <FKFunction>)function;

+ (id <FKEffect>)effectFromSelector:(SEL)s;

+ (id <FKEffect>)effectFromSelector:(SEL)s withArgument:(id)argument;

+ (id <FKEffect>)effectFromSelector:(SEL)s target:(NSObject *)target;

+ (id <FKEffect>)effectFromPointer:(fkEffect)f;
@end
