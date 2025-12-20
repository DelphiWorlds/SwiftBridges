// SHLibraryOC.h

#import <Foundation/Foundation.h>

@class SHMediaItemOC;

NS_ASSUME_NONNULL_BEGIN

@interface SHLibraryOC : NSObject

+ (SHLibraryOC *)defaultLibrary;

- (NSArray<SHMediaItemOC *> *)items;

- (void)addItems:(NSArray<SHMediaItemOC *> *)items completion:(void (^)(NSError * _Nullable error))completion;

- (void)removeItems:(NSArray<SHMediaItemOC *> *)items completion:(void (^)(NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
