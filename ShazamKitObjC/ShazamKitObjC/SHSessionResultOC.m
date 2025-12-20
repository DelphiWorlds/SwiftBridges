// SHSessionResultOC.m

#import "SHSessionResultOC.h"
#import "SHMatchOC.h"
#import "SHSignatureOC.h"
#import <ShazamKitObjC/ShazamKitObjC-Swift.h>

@interface SHSessionResultOC ()

@property (nonatomic, strong, readonly) SHSessionResultSwift *swiftResult;

- (instancetype)initWithSwiftResult:(SHSessionResultSwift *)swiftResult NS_DESIGNATED_INITIALIZER;

@end

// Private initializers for wrapped types
@interface SHMatchOC ()
- (instancetype)initWithSwiftMatch:(SHMatchSwift *)swiftMatch;
@end

@interface SHSignatureOC ()
- (instancetype)initWithSwiftSignature:(SHSignatureSwift *)swiftSignature;
@end

@implementation SHSessionResultOC

- (instancetype)initWithSwiftResult:(SHSessionResultSwift *)swiftResult {
    if (self = [super init]) {
        _swiftResult = swiftResult;
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Use initWithSwiftResult: instead"
                                 userInfo:nil];
    return nil;
}

- (BOOL)isMatch { return _swiftResult.isMatch; }
- (BOOL)isNoMatch { return _swiftResult.isNoMatch; }
- (BOOL)isError { return _swiftResult.isError; }

- (SHMatchOC *)match {
    return _swiftResult.match ? [[SHMatchOC alloc] initWithSwiftMatch:_swiftResult.match] : nil;
}

- (SHSignatureOC *)signature {
    return _swiftResult.signature ? [[SHSignatureOC alloc] initWithSwiftSignature:_swiftResult.signature] : nil;
}

- (NSError *)error { return _swiftResult.error; }

@end
