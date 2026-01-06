// DeclaredAgeRangeOC.h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AgeRangeResponseOC;

NS_ASSUME_NONNULL_BEGIN

@interface DeclaredAgeRangeOC : NSObject

+ (DeclaredAgeRangeOC *)shared;

/*
 The method name below now exactly matches the selector exposed by Swift:
 requestAgeRangeWithThreshold:threshold2:threshold3:viewController:completion:
 */
- (void)requestAgeRangeWithThreshold:(NSInteger)threshold
                            threshold2:(NSInteger)threshold2
                            threshold3:(NSInteger)threshold3
                        viewController:(UIViewController *)viewController
                            completion:(void (^)(AgeRangeResponseOC * _Nullable response, NSError * _Nullable error))completion;

- (void)isEligibleForAgeFeaturesWithCompletion:(void (^)(BOOL eligible, NSError * _Nullable error))completion NS_AVAILABLE_IOS(26_2);

@end

NS_ASSUME_NONNULL_END
