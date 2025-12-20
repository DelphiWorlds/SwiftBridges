// SHLibraryOC.m

#import "SHLibraryOC.h"
#import "SHMediaItemOC.h"
#import <ShazamKitObjC/ShazamKitObjC-Swift.h>

@interface SHLibraryOC ()

@property (nonatomic, strong, readonly) SHLibrarySwift *swiftLibrary;

@end

// Private extension to access swiftItem and initializer
@interface SHMediaItemOC ()

@property (nonatomic, strong, readonly) SHMediaItemSwift *swiftItem;

- (instancetype)initWithSwiftItem:(SHMediaItemSwift *)swiftItem;

@end

@implementation SHLibraryOC

+ (SHLibraryOC *)defaultLibrary {
    static SHLibraryOC *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SHLibraryOC alloc] init];
    });
    return shared;
}

- (instancetype)init {
    if (self = [super init]) {
        _swiftLibrary = [SHLibrarySwift defaultLibrary];
    }
    return self;
}

- (NSArray<SHMediaItemOC *> *)items {
    NSArray<SHMediaItemSwift *> *swiftItems = _swiftLibrary.items;
    NSMutableArray<SHMediaItemOC *> *ocItems = [NSMutableArray array];
    for (SHMediaItemSwift *swiftItem in swiftItems) {
        [ocItems addObject:[[SHMediaItemOC alloc] initWithSwiftItem:swiftItem]];  // Now visible
    }
    return ocItems;
}

- (void)addItems:(NSArray<SHMediaItemOC *> *)items completion:(void (^)(NSError * _Nullable))completion {
    NSMutableArray<SHMediaItemSwift *> *swiftItems = [NSMutableArray array];
    for (SHMediaItemOC *ocItem in items) {
        [swiftItems addObject:ocItem.swiftItem];
    }
    [_swiftLibrary addItems:swiftItems completion:completion];
}

- (void)removeItems:(NSArray<SHMediaItemOC *> *)items completion:(void (^)(NSError * _Nullable))completion {
    NSMutableArray<SHMediaItemSwift *> *swiftItems = [NSMutableArray array];
    for (SHMediaItemOC *ocItem in items) {
        [swiftItems addObject:ocItem.swiftItem];
    }
    [_swiftLibrary removeItems:swiftItems completion:completion];
}

@end
