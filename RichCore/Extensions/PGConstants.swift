// Copyright © 2020 PeoGooCore. All rights reserved.
import Foundation
import UIKit

/// Pre-defined constants related to views' corner radii.
public enum PGCornerRadius {
    /// The project's default corner radius, at 8pt.
    public static let `default`: CGFloat = 8
    /// The project's large corner radius, at 16pt.
    public static let large: CGFloat = 16
    /// The small corner radius used in consecutive chat messages.
    public static let cornerMcCornerfaceSmall: CGFloat = 2
    /// The large corner radius used in consecutive chat messages.
    public static let cornerMcCornerfaceLarge: CGFloat = 12
    /// The corner radius of the device's screen, which is present only on iPhone X family devices.
    public static let device: CGFloat = UIDevice.isIPhoneX ? 40 : 0
}

/// Pre-defined constants related to animation and transition durations.
public enum PGDuration {
    /// Determines how the project's animations and transitions durations should compare to the native ones.
    public static let proportion = 1.3
    /// The iOS native animation and transition duration.
    public static let native: TimeInterval = 0.25
    /// The project's default animation and transition duration.
    public static let `default`: TimeInterval = 0.25
}

/// Pre-defined constants related to maximum length of strings, based on use case.
public enum PGStringLength {
    /// Max length of user's alias.
    public static let userAlias = 50
    /// Max length of user's name, e.g. first or last names.
    public static let userName = 25
    /// Max legnth of a contact's nickname.
    public static let contactNickname = 25
    /// Max length of a user's password.
    /// - Note: should be purely to limit users registering new passwords, and *not* when entering password fields in sign in forms.
    public static let password = 256
    /// Max length of custom channel's name.
    public static let channelName = 25
    /// Max length of unit prefixes.
    public static let unitPrefix = 7
}

// MARK: - Legacy
/// ZLDuration's bridging class to interact with Objective-C classes.
@objc public final class ObjC_PGDuration : NSObject {
    /// The project's default animation and transition duration.
    @objc public static let _default: TimeInterval = PGDuration.default
}
