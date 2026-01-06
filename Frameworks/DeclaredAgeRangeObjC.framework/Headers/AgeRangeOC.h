// AgeRangeOC.h

#import <Foundation/Foundation.h>

@class ParentalControlsOC;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AgeRangeDeclaration) {
    AgeRangeDeclarationNone = -1,
    AgeRangeDeclarationSelfDeclared = 0,
    AgeRangeDeclarationGuardianDeclared = 1,
    AgeRangeDeclarationCheckedByOtherMethod = 2,
    AgeRangeDeclarationGuardianCheckedByOtherMethod = 3,
    AgeRangeDeclarationGovernmentIDChecked = 4,
    AgeRangeDeclarationGuardianGovernmentIDChecked = 5,
    AgeRangeDeclarationPaymentChecked = 6,
    AgeRangeDeclarationGuardianPaymentChecked = 7,
    AgeRangeDeclarationUnknown = 999
};

@interface AgeRangeOC : NSObject

@property (nonatomic, strong, readonly, nullable) NSNumber *lowerBound;
@property (nonatomic, strong, readonly, nullable) NSNumber *upperBound;
@property (nonatomic, strong, readonly, nullable) NSNumber *ageRangeDeclarationRawValue;
@property (nonatomic, readonly) AgeRangeDeclaration ageRangeDeclarationType;
@property (nonatomic, assign, readonly) NSInteger parentalControlsRawValue;
@property (nonatomic, strong, readonly) ParentalControlsOC *activeParentalControls;

- (instancetype)initWithLowerBound:(NSNumber *)lowerBound
                        upperBound:(NSNumber *)upperBound
              ageRangeDeclarationRawValue:(NSNumber *)ageRangeDeclarationRawValue
                 parentalControlsRawValue:(NSInteger)parentalControlsRawValue;

@end

NS_ASSUME_NONNULL_END
