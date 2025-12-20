// SHMediaItemOC.m

#import "SHMediaItemOC.h"
#import <ShazamKitObjC/ShazamKitObjC-Swift.h>

@interface SHMediaItemOC ()

@property (nonatomic, strong, readonly) SHMediaItemSwift *swiftItem;

- (instancetype)initWithSwiftItem:(SHMediaItemSwift *)swiftItem NS_DESIGNATED_INITIALIZER;

@end

@implementation SHMediaItemOC

- (instancetype)initWithSwiftItem:(SHMediaItemSwift *)swiftItem {
    if (self = [super init]) {
        _swiftItem = swiftItem;
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Use initWithSwiftItem: instead"
                                 userInfo:nil];
    return nil;
}

- (NSString *)title { return _swiftItem.title; }
- (NSString *)subtitle { return _swiftItem.subtitle; }
- (NSString *)artist { return _swiftItem.artist; }
- (NSURL *)artworkURL { return _swiftItem.artworkURL; }
- (NSString *)shazamID { return _swiftItem.shazamID; }
- (NSString *)appleMusicID { return _swiftItem.appleMusicID; }
- (NSURL *)appleMusicURL { return _swiftItem.appleMusicURL; }
- (NSURL *)webURL { return _swiftItem.webURL; }
- (NSURL *)videoURL { return _swiftItem.videoURL; }
- (NSString *)isrc { return _swiftItem.isrc; }

- (NSArray *)timeRanges { return _swiftItem.timeRanges; }
- (NSArray *)frequencySkewRanges { return _swiftItem.frequencySkewRanges; }
- (NSArray *)songs { return _swiftItem.songs; }

- (NSUUID *)id { return _swiftItem.id; }

@end
