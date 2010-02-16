#import <Foundation/Foundation.h>

#import "FKEither.h"

@interface NSString (FunctionalKitExtensions)

+ (FKEither *)loadContentsOfFile:(NSString *)path;

@end
