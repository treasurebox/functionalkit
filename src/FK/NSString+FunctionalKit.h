#import <Foundation/Foundation.h>
#import "FKEither.h"
#import "FKFunction.h"

@interface NSString (FunctionalKitExtensions)

// String concatentation as a function.
+ (FKFunction2 *)concatF;

+ (FKEither *)loadContentsOfFile:(NSString *)path;

@end
