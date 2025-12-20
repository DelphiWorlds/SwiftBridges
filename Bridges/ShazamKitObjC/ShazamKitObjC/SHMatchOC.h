// SHMatchOC.h

#import <Foundation/Foundation.h>

@class SHMediaItemOC;

NS_ASSUME_NONNULL_BEGIN

@interface SHMatchOC : NSObject

@property (nonatomic, strong, readonly) NSArray<SHMediaItemOC *> *mediaItems;

@end

NS_ASSUME_NONNULL_END
