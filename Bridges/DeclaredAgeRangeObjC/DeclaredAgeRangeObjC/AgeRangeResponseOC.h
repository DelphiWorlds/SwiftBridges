// AgeRangeResponseOC.h

#import <Foundation/Foundation.h>

@class AgeRangeOC;

NS_ASSUME_NONNULL_BEGIN

@interface AgeRangeResponseOC : NSObject

@property (nonatomic, readonly) BOOL declinedSharing;

@property (nonatomic, strong, readonly, nullable) AgeRangeOC *sharedRange;

@end

NS_ASSUME_NONNULL_END
