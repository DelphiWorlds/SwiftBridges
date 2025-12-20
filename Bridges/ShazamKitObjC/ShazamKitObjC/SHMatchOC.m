// SHMatchOC.m

#import "SHMatchOC.h"
#import "SHMediaItemOC.h"
#import <ShazamKitObjC/ShazamKitObjC-Swift.h>

@interface SHMatchOC ()

@property (nonatomic, strong, readonly) SHMatchSwift *swiftMatch;

- (instancetype)initWithSwiftMatch:(SHMatchSwift *)swiftMatch NS_DESIGNATED_INITIALIZER;

@end

@interface SHMediaItemOC ()
@property (nonatomic, strong, readonly) SHMediaItemSwift *swiftItem;
- (instancetype)initWithSwiftItem:(SHMediaItemSwift *)swiftItem;
@end

@implementation SHMatchOC

- (instancetype)initWithSwiftMatch:(SHMatchSwift *)swiftMatch {
    if (self = [super init]) {
        _swiftMatch = swiftMatch;
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Use initWithSwiftMatch: instead"
                                 userInfo:nil];
    return nil;
}

- (NSArray<SHMediaItemOC *> *)mediaItems {
    NSMutableArray<SHMediaItemOC *> *ocItems = [NSMutableArray array];
    for (SHMediaItemSwift *swiftItem in _swiftMatch.mediaItems) {
        [ocItems addObject:[[SHMediaItemOC alloc] initWithSwiftItem:swiftItem]];
    }
    return ocItems;
}

@end
