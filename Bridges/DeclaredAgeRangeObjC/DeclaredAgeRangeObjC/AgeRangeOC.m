// AgeRangeOC.m

#import "AgeRangeOC.h"
#import "ParentalControlsOC.h"

@implementation AgeRangeOC

- (instancetype)initWithLowerBound:(NSNumber *)lowerBound
                        upperBound:(NSNumber *)upperBound
              ageRangeDeclarationRawValue:(NSNumber *)ageRangeDeclarationRawValue
                 parentalControlsRawValue:(NSInteger)parentalControlsRawValue {
    if (self = [super init]) {
        _lowerBound = lowerBound;
        _upperBound = upperBound;
        _ageRangeDeclarationRawValue = ageRangeDeclarationRawValue;
        _parentalControlsRawValue = parentalControlsRawValue;
    }
    return self;
}

- (NSNumber *)ageRangeDeclaration {
    return _ageRangeDeclarationRawValue;
}

- (AgeRangeDeclaration)ageRangeDeclarationType {
    NSNumber *decl = self.ageRangeDeclarationRawValue;
    
    if (!decl) {
        return AgeRangeDeclarationNone;
    }
    
    NSInteger value = decl.integerValue;
    
    if (value >= AgeRangeDeclarationSelfDeclared && value <= AgeRangeDeclarationGuardianPaymentChecked) {
        return (AgeRangeDeclaration)value;
    }
    
    return AgeRangeDeclarationUnknown;
}

- (ParentalControlsOC *)activeParentalControls {
    return [[ParentalControlsOC alloc] initWithRawValue:self.parentalControlsRawValue];
}

@end
