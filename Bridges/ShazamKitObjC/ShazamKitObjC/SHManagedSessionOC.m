// SHManagedSessionOC.m

#import "SHManagedSessionOC.h"
#import "SHSessionResultOC.h"
#import "SHCatalogOC.h"
#import <ShazamKitObjC/ShazamKitObjC-Swift.h>

@interface SHManagedSessionOC ()

@property (nonatomic, strong, readonly) SHManagedSessionSwift *swiftSession;

@end

@interface SHCatalogOC ()
@property (nonatomic, strong, readonly) SHCatalogSwift *swiftCatalog;
@end

// Private initializer for SHSessionResultOC
@interface SHSessionResultOC ()
- (instancetype)initWithSwiftResult:(SHSessionResultSwift *)swiftResult;
@end

@implementation SHManagedSessionOC

+ (NSInteger)stateIdle { return 0; }
+ (NSInteger)statePrerecording { return 1; }
+ (NSInteger)stateMatching { return 2; }

- (instancetype)init {
    if (self = [super init]) {
        _swiftSession = [[SHManagedSessionSwift alloc] init];
    }
    return self;
}

- (instancetype)initWithCatalog:(SHCatalogOC *)catalog {
    if (self = [super init]) {
        _swiftSession = [[SHManagedSessionSwift alloc] initWithCatalog:catalog.swiftCatalog];
    }
    return self;
}

- (NSInteger)state {
    return _swiftSession.state;
}

- (void)prepareWithCompletion:(void (^)(void))completion {
    [_swiftSession prepareWithCompletion:completion];
}

- (void)cancel {
    [_swiftSession cancel];
}

- (void)resultWithCompletion:(void (^)(SHSessionResultOC * _Nullable))completion {
    [_swiftSession resultWithCompletion:^(SHSessionResultSwift * _Nullable swiftResult, NSError * _Nullable error) {
        SHSessionResultOC *ocResult = swiftResult ? [[SHSessionResultOC alloc] initWithSwiftResult:swiftResult] : nil;  // Now visible
        completion(ocResult);
    }];
}

@end
