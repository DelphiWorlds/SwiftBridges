// SHSessionResultOC.h

#import <Foundation/Foundation.h>

@class SHMatchOC;
@class SHSignatureOC;

NS_ASSUME_NONNULL_BEGIN

@interface SHSessionResultOC : NSObject

@property (nonatomic, readonly) BOOL isMatch;
@property (nonatomic, readonly) BOOL isNoMatch;
@property (nonatomic, readonly) BOOL isError;

@property (nonatomic, strong, readonly, nullable) SHMatchOC *match;
@property (nonatomic, strong, readonly, nullable) SHSignatureOC *signature;
@property (nonatomic, strong, readonly, nullable) NSError *error;

@end

NS_ASSUME_NONNULL_END
