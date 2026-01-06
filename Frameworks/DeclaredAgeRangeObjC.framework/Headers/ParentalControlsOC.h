// ParentalControlsOC.h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParentalControlsOC : NSObject

@property (nonatomic, readonly) NSInteger rawValue;

@property (nonatomic, readonly) BOOL communicationLimits;
@property (nonatomic, readonly) BOOL significantAppChangeApprovalRequired;

- (instancetype)initWithRawValue:(NSInteger)rawValue;

+ (ParentalControlsOC *)communicationLimits;
+ (ParentalControlsOC *)significantAppChangeApprovalRequired;

@end

NS_ASSUME_NONNULL_END
