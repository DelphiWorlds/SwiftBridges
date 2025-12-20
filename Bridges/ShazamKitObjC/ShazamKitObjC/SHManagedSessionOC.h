// SHManagedSessionOC.h

#import <Foundation/Foundation.h>

@class SHCatalogOC;
@class SHSessionResultOC;

NS_ASSUME_NONNULL_BEGIN

@interface SHManagedSessionOC : NSObject

@property (nonatomic, readonly) NSInteger state;  // 0 = idle, 1 = prerecording, 2 = matching

+ (NSInteger)stateIdle;
+ (NSInteger)statePrerecording;
+ (NSInteger)stateMatching;

- (instancetype)init;

- (instancetype)initWithCatalog:(SHCatalogOC *)catalog;

- (void)prepareWithCompletion:(void (^)(void))completion;

- (void)cancel;

- (void)resultWithCompletion:(void (^)(SHSessionResultOC * _Nullable result))completion;

@end

NS_ASSUME_NONNULL_END
