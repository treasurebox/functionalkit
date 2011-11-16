#import <Foundation/Foundation.h>
#import "FK/FKFunction.h"

@interface FKFunction (CommonFunctions)

+ (FKFunction *)const:(id)constantReturnValue;

+ (FKFunction *)identity;

@end
