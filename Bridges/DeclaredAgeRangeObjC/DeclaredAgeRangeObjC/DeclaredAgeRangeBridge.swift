//
//  DeclaredAgeRangeBridge.swift
//  DeclaredAgeRangeObjC
//
//  Fixed for correct Objective-C exposure and singleton behavior
//

import Foundation
import UIKit
// import os

@preconcurrency import DeclaredAgeRange

// MARK: - AgeRangeServiceSwift (singleton + correct parameter labels)

@available(iOS 26.0, *)
@objcMembers
public final class AgeRangeServiceSwift: NSObject {

    // private let logger = Logger();
    public static let shared = AgeRangeServiceSwift()

    private override init() {
        super.init()
    }

    // This method's parameter labels MUST produce the exact selector expected in Objective-C:
    // requestAgeRangeWithThreshold:threshold2:threshold3:viewController:completion:
    nonisolated public func requestAgeRangeWithThreshold(_ threshold: Int,
                                                         threshold2: Int,
                                                         threshold3: Int,
                                                         viewController: UIViewController,
                                                         completion: @escaping (AgeRangeResponseSwift?, NSError?) -> Void) {
        // logger.log("AgeRangeServiceSwift.requestAgeRangeWithThreshold");
        nonisolated(unsafe) let unsafeCompletion = completion
        Task { @MainActor in
            do {
                // logger.log("> try await AgeRangeService.shared.requestAgeRange");
                let response = try await AgeRangeService.shared.requestAgeRange(ageGates: threshold, threshold2, threshold3, in: viewController)
                let swiftResponse = AgeRangeResponseSwift(response: response)
                unsafeCompletion(swiftResponse, nil)
            } catch {
                unsafeCompletion(nil, error as NSError)
            }
        }
    }

    @available(iOS 26.2, *)
    nonisolated public func isEligibleForAgeFeatures(completion: @escaping (Bool, NSError?) -> Void) {
        nonisolated(unsafe) let unsafeCompletion = completion

        Task { @MainActor in
            do {
                let eligible = try await AgeRangeService.shared.isEligibleForAgeFeatures
                unsafeCompletion(eligible, nil)
            } catch {
                unsafeCompletion(false, error as NSError)
            }
        }
    }
}

// MARK: - AgeRangeDeclarationSwift

@available(iOS 26.0, *)
@objc
public enum AgeRangeDeclarationSwift: Int {
    case selfDeclared
    case guardianDeclared

    @available(iOS 26.2, *)
    case checkedByOtherMethod

    @available(iOS 26.2, *)
    case guardianCheckedByOtherMethod

    @available(iOS 26.2, *)
    case governmentIDChecked

    @available(iOS 26.2, *)
    case guardianGovernmentIDChecked

    @available(iOS 26.2, *)
    case paymentChecked

    @available(iOS 26.2, *)
    case guardianPaymentChecked
}

// MARK: - ParentalControlsSwift

@available(iOS 26.0, *)
@objcMembers
public final class ParentalControlsSwift: NSObject {

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
        super.init()
    }

    nonisolated(unsafe) public static let communicationLimits = ParentalControlsSwift(rawValue: AgeRangeService.ParentalControls.communicationLimits.rawValue)

    nonisolated(unsafe) public static let significantAppChangeApprovalRequired = ParentalControlsSwift(rawValue: AgeRangeService.ParentalControls.significantAppChangeApprovalRequired.rawValue)
}

// MARK: - AgeRangeSwift

@available(iOS 26.0, *)
@objcMembers
public final class AgeRangeSwift: NSObject {

    internal let range: AgeRangeService.AgeRange

    internal init(range: AgeRangeService.AgeRange) {
        self.range = range
        super.init()
    }

    public var lowerBound: NSNumber? {
        range.lowerBound.map { NSNumber(value: $0) }
    }

    public var upperBound: NSNumber? {
        range.upperBound.map { NSNumber(value: $0) }
    }

    public var ageRangeDeclarationRawValue: NSNumber? {
        range.ageRangeDeclaration.map { NSNumber(value: $0.hashValue) }
    }

    public var activeParentalControls: ParentalControlsSwift {
        ParentalControlsSwift(rawValue: range.activeParentalControls.rawValue)
    }
}

// MARK: - AgeRangeResponseSwift

@available(iOS 26.0, *)
@objcMembers
public final class AgeRangeResponseSwift: NSObject {

    private let response: AgeRangeService.Response

    internal init(response: AgeRangeService.Response) {
        self.response = response
        super.init()
    }

    public var declinedSharing: Bool {
        if case .declinedSharing = response { return true }
        return false
    }

    public var sharedRange: AgeRangeSwift? {
        if case .sharing(let range) = response {
            return AgeRangeSwift(range: range)
        }
        return nil
    }
}
