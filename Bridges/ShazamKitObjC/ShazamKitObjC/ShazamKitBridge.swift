//
//  ShazamKitBridge.swift
//  ShazamKitObjC
//
//  Created by Dave Nottage on 20/12/2025.
//

import Foundation
import ShazamKit
import MusicKit

// MARK: - SHLibrarySwift

@available(iOS 17.0, *)
@objcMembers
public final class SHLibrarySwift: NSObject {

    public class func defaultLibrary() -> SHLibrarySwift {
        SHLibrarySwift()
    }

    private override init() {
        super.init()
    }

    @MainActor
    public var items: NSArray {
        SHLibrary.default.items as NSArray
    }

    public func addItems(_ items: [SHMediaItemSwift]) async throws {
        let nativeItems = items.map { $0.mediaItem }
        try await SHLibrary.default.addItems(nativeItems)
    }

    public func removeItems(_ items: [SHMediaItemSwift]) async throws {
        let nativeItems = items.map { $0.mediaItem }
        try await SHLibrary.default.removeItems(nativeItems)
    }

    nonisolated public func addItems(_ items: [SHMediaItemSwift], completion: @escaping (NSError?) -> Void) {
        nonisolated(unsafe) let unsafeItems = items
        nonisolated(unsafe) let unsafeCompletion = completion

        Task { @MainActor in
            do {
                let nativeItems = unsafeItems.map { $0.mediaItem }
                try await SHLibrary.default.addItems(nativeItems)
                unsafeCompletion(nil)
            } catch {
                unsafeCompletion(error as NSError)
            }
        }
    }

    nonisolated public func removeItems(_ items: [SHMediaItemSwift], completion: @escaping (NSError?) -> Void) {
        nonisolated(unsafe) let unsafeItems = items
        nonisolated(unsafe) let unsafeCompletion = completion

        Task { @MainActor in
            do {
                let nativeItems = unsafeItems.map { $0.mediaItem }
                try await SHLibrary.default.removeItems(nativeItems)
                unsafeCompletion(nil)
            } catch {
                unsafeCompletion(error as NSError)
            }
        }
    }
}

// MARK: - SHManagedSessionSwift

@available(iOS 17.0, *)
@objcMembers
public final class SHManagedSessionSwift: NSObject {

    private let session: SHManagedSession

    @MainActor
    public var state: Int {
        switch session.state {
        case .idle: return 0
        case .prerecording: return 1
        case .matching: return 2
        @unknown default: return -1
        }
    }

    public class var stateIdle: Int { 0 }
    public class var statePrerecording: Int { 1 }
    public class var stateMatching: Int { 2 }

    @objc public override init() {
        self.session = SHManagedSession()
        super.init()
    }

    @objc public init(catalog: SHCatalogSwift) {
        self.session = SHManagedSession(catalog: catalog.catalog)
        super.init()
    }

    public func prepare() async {
        await session.prepare()
    }

    public func cancel() {
        session.cancel()
    }

    public func result() async -> SHSessionResultSwift {
        let nativeResult = await session.result()
        return SHSessionResultSwift(result: nativeResult)
    }

    nonisolated public func prepare(completion: @escaping () -> Void) {
        nonisolated(unsafe) let unsafeSelf = self
        nonisolated(unsafe) let unsafeCompletion = completion

        Task { @MainActor in
            await unsafeSelf.session.prepare()
            unsafeCompletion()
        }
    }

    nonisolated public func result(completion: @escaping (SHSessionResultSwift?, NSError?) -> Void) {
        nonisolated(unsafe) let unsafeSelf = self
        nonisolated(unsafe) let unsafeCompletion = completion

        Task { @MainActor in
            let nativeResult = await unsafeSelf.session.result()
            unsafeCompletion(SHSessionResultSwift(result: nativeResult), nil)
        }
    }
}

// MARK: - Supporting Swift wrapper classes (unchanged from previous versions)

@available(iOS 15.0, *)
@objcMembers
public final class SHMediaItemSwift: NSObject {
    internal let mediaItem: SHMediaItem
    internal init(mediaItem: SHMediaItem) {
        self.mediaItem = mediaItem
        super.init()
    }

    public var title: String? { mediaItem.title }
    public var subtitle: String? { mediaItem.subtitle }
    public var artist: String? { mediaItem.artist }
    public var artworkURL: URL? { mediaItem.artworkURL }
    public var shazamID: String? { mediaItem.shazamID }
    public var appleMusicID: String? { mediaItem.appleMusicID }
    public var appleMusicURL: URL? { mediaItem.appleMusicURL }
    public var webURL: URL? { mediaItem.webURL }
    public var videoURL: URL? { mediaItem.videoURL }
    public var isrc: String? { mediaItem.isrc }

    @available(iOS 16.0, *)
    public var timeRanges: NSArray { mediaItem.timeRanges as NSArray }

    @available(iOS 16.0, *)
    public var frequencySkewRanges: NSArray { mediaItem.frequencySkewRanges as NSArray }

    @available(iOS 16.0, *)
    public var songs: NSArray { mediaItem.songs as NSArray }

    @available(iOS 17.0, *)
    public var id: NSUUID { mediaItem.id as NSUUID }
}

@available(iOS 16.0, *)
@objcMembers
public final class SHSessionResultSwift: NSObject {
    private let result: SHSession.Result
    internal init(result: SHSession.Result) {
        self.result = result
        super.init()
    }

    public var isMatch: Bool { if case .match = result { return true }; return false }
    public var isNoMatch: Bool { if case .noMatch = result { return true }; return false }
    public var isError: Bool { if case .error = result { return true }; return false }

    public var match: SHMatchSwift? {
        if case .match(let m) = result { return SHMatchSwift(match: m) }
        return nil
    }

    public var signature: SHSignatureSwift? {
        switch result {
        case .noMatch(let sig), .error(_, let sig): return SHSignatureSwift(signature: sig)
        default: return nil
        }
    }

    public var error: NSError? {
        if case .error(let err, _) = result { return err as NSError }
        return nil
    }
}

@available(iOS 15.0, *)
@objcMembers
public final class SHCatalogSwift: NSObject {
    internal let catalog: SHCatalog
    internal init(catalog: SHCatalog) {
        self.catalog = catalog
        super.init()
    }
}

@available(iOS 15.0, *)
@objcMembers
public final class SHMatchSwift: NSObject {
    internal let match: SHMatch
    internal init(match: SHMatch) {
        self.match = match
        super.init()
    }

    public var mediaItems: NSArray { match.mediaItems as NSArray }
}

@available(iOS 15.0, *)
@objcMembers
public final class SHSignatureSwift: NSObject {
    internal let signature: SHSignature
    internal init(signature: SHSignature) {
        self.signature = signature
        super.init()
    }
}
