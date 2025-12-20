// SHSignatureOC.m

#import "SHSignatureOC.h"
#import <ShazamKitObjC/ShazamKitObjC-Swift.h>

@interface SHSignatureOC ()

@property (nonatomic, strong, readonly) SHSignatureSwift *swiftSignature;

- (instancetype)initWithSwiftSignature:(SHSignatureSwift *)swiftSignature NS_DESIGNATED_INITIALIZER;

@end

@implementation SHSignatureOC

- (instancetype)initWithSwiftSignature:(SHSignatureSwift *)swiftSignature {
    if (self = [super init]) {  // <-- Added super call
        _swiftSignature = swiftSignature;
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Use initWithSwiftSignature: instead"
                                 userInfo:nil];
    return nil;
}

@end
