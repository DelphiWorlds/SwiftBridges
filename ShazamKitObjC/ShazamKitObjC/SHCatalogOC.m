// SHCatalogOC.m

#import "SHCatalogOC.h"
#import <ShazamKitObjC/ShazamKitObjC-Swift.h>

@interface SHCatalogOC ()

@property (nonatomic, strong, readonly) SHCatalogSwift *swiftCatalog;

- (instancetype)initWithSwiftCatalog:(SHCatalogSwift *)swiftCatalog NS_DESIGNATED_INITIALIZER;

@end

@implementation SHCatalogOC

- (instancetype)initWithSwiftCatalog:(SHCatalogSwift *)swiftCatalog {
    if (self = [super init]) {
        _swiftCatalog = swiftCatalog;
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Use initWithSwiftCatalog: instead"
                                 userInfo:nil];
    return nil;
}

@end
