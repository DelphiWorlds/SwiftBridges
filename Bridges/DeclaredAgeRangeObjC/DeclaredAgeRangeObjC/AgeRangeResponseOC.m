// AgeRangeResponseOC.m

#import "AgeRangeResponseOC.h"
#import "AgeRangeOC.h"
#import <DeclaredAgeRangeObjC/DeclaredAgeRangeObjC-Swift.h>

@interface AgeRangeResponseOC ()

@property (nonatomic, strong, readonly) AgeRangeResponseSwift *swiftResponse;

@end

@implementation AgeRangeResponseOC

- (instancetype)initWithSwiftResponse:(AgeRangeResponseSwift *)swiftResponse {
    if (self = [super init]) {
        _swiftResponse = swiftResponse;
    }
    return self;
}

- (instancetype)init {
    return [self initWithSwiftResponse:nil];
}

- (BOOL)declinedSharing {
    return _swiftResponse.declinedSharing;
}

- (AgeRangeOC *)sharedRange {
    AgeRangeSwift *swiftRange = _swiftResponse.sharedRange;
    
    if (!swiftRange) {
        return nil;
    }
    
    // Extract EVERYTHING while swiftRange is guaranteed alive
    NSNumber *lowerBound = swiftRange.lowerBound ?: nil;
    NSNumber *upperBound = swiftRange.upperBound ?: nil;
    NSNumber *ageDeclRaw = swiftRange.ageRangeDeclarationRawValue ?: nil;
    NSInteger parentalRaw = swiftRange.activeParentalControls.rawValue;
    
    // Create pure OC object — no Swift references
    return [[AgeRangeOC alloc] initWithLowerBound:lowerBound
                                       upperBound:upperBound
                          ageRangeDeclarationRawValue:ageDeclRaw
                             parentalControlsRawValue:parentalRaw];
}

@end
