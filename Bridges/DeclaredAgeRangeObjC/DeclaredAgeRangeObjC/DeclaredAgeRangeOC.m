// DeclaredAgeRangeOC.m

// #import <OSLog/OSLog.h>
#import "DeclaredAgeRangeOC.h"
#import "AgeRangeResponseOC.h"
#import <DeclaredAgeRangeObjC/DeclaredAgeRangeObjC-Swift.h>

// Private extensions for response conversion
@interface AgeRangeResponseOC ()
- (instancetype)initWithSwiftResponse:(AgeRangeResponseSwift *)swiftResponse;
@end


@interface DeclaredAgeRangeOC ()

@property (nonatomic, strong, readonly) AgeRangeServiceSwift *swiftService;

@end

@implementation DeclaredAgeRangeOC

+ (DeclaredAgeRangeOC *)shared {
    static DeclaredAgeRangeOC *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[DeclaredAgeRangeOC alloc] init];
    });
    return shared;
}

- (instancetype)init {
    if (self = [super init]) {
        _swiftService = [AgeRangeServiceSwift shared];
    }
    return self;
}

- (void)requestAgeRangeWithThreshold:(NSInteger)threshold
                            threshold2:(NSInteger)threshold2
                            threshold3:(NSInteger)threshold3
                        viewController:(UIViewController *)viewController
                            completion:(void (^)(AgeRangeResponseOC * _Nullable response, NSError * _Nullable error))completion {
    
    // os_log_info(OS_LOG_DEFAULT, "DeclaredAgeRangeOC.requestAgeRangeWithThreshold");
    // Forward to the exact Swift-exposed method name and signature
    [_swiftService requestAgeRangeWithThreshold:(int)threshold
                                      // threshold2:t2
                                      // threshold3:t3
                                      threshold2:(int)threshold2
                                      threshold3:(int)threshold3
                                  viewController:viewController
                                      completion:^(AgeRangeResponseSwift * _Nullable swiftResponse, NSError * _Nullable error) {
        AgeRangeResponseOC *ocResponse = nil;
        if (swiftResponse) {
            ocResponse = [[AgeRangeResponseOC alloc] initWithSwiftResponse:swiftResponse];
        }
        completion(ocResponse, error);
    }];
}

- (void)isEligibleForAgeFeaturesWithCompletion:(void (^)(BOOL eligible, NSError * _Nullable error))completion {
    if (@available(iOS 26.2, *)) {
        [_swiftService isEligibleForAgeFeaturesWithCompletion:completion];
    } else {
        // On older iOS versions, immediately return not eligible with nil error
        completion(NO, nil);
    }
}

@end
