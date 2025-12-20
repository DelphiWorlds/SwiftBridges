// SHMediaItemOC.h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHMediaItemOC : NSObject

@property (nonatomic, copy, readonly, nullable) NSString *title;
@property (nonatomic, copy, readonly, nullable) NSString *subtitle;
@property (nonatomic, copy, readonly, nullable) NSString *artist;
@property (nonatomic, strong, readonly, nullable) NSURL *artworkURL;
@property (nonatomic, copy, readonly, nullable) NSString *shazamID;
@property (nonatomic, copy, readonly, nullable) NSString *appleMusicID;
@property (nonatomic, strong, readonly, nullable) NSURL *appleMusicURL;
@property (nonatomic, strong, readonly, nullable) NSURL *webURL;
@property (nonatomic, strong, readonly, nullable) NSURL *videoURL;
@property (nonatomic, copy, readonly, nullable) NSString *isrc;

@property (nonatomic, strong, readonly) NSArray *timeRanges NS_AVAILABLE_IOS(16_0);
@property (nonatomic, strong, readonly) NSArray *frequencySkewRanges NS_AVAILABLE_IOS(16_0);
@property (nonatomic, strong, readonly) NSArray *songs NS_AVAILABLE_IOS(16_0);

@property (nonatomic, strong, readonly) NSUUID *id NS_AVAILABLE_IOS(17_0);

@end

NS_ASSUME_NONNULL_END
