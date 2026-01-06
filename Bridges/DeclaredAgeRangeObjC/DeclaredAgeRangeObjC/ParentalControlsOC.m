// ParentalControlsOC.m

#import "ParentalControlsOC.h"
#import <DeclaredAgeRangeObjC/DeclaredAgeRangeObjC-Swift.h>

@implementation ParentalControlsOC

- (instancetype)initWithRawValue:(NSInteger)rawValue {
    if (self = [super init]) {
        _rawValue = rawValue;
    }
    return self;
}

+ (ParentalControlsOC *)communicationLimits {
    return [[ParentalControlsOC alloc] initWithRawValue:ParentalControlsSwift.communicationLimits.rawValue];
}

+ (ParentalControlsOC *)significantAppChangeApprovalRequired {
    static ParentalControlsOC *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 26.2, *)) {
            instance = [[ParentalControlsOC alloc] initWithRawValue:ParentalControlsSwift.significantAppChangeApprovalRequired.rawValue];
        } else {
            instance = [[ParentalControlsOC alloc] initWithRawValue:0];
        }
    });
    return instance;
}

- (BOOL)communicationLimits {
    return (self.rawValue & ParentalControlsSwift.communicationLimits.rawValue) != 0;
}

- (BOOL)significantAppChangeApprovalRequired {
    if (@available(iOS 26.2, *)) {
        return (self.rawValue & ParentalControlsSwift.significantAppChangeApprovalRequired.rawValue) != 0;
    }
    return NO;
}

@end
