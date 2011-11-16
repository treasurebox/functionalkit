#import <Foundation/Foundation.h>
#import "FK/FKEither.h"
#import "FK/FKFunction.h"

@interface NSString (FunctionalKitExtensions)

// String concatentation as a function.
+ (FKFunction2 *)concatF;

+ (FKEither *)loadContentsOfFile:(NSString *)path;

@end
