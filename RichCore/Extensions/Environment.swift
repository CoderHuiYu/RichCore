// Copyright © 2020 PeoGooCore. All rights reserved.

/// Represents the build environment, needs to be the first thing to be set in order to have the correct API keys.
public enum Environment : String {
    case development, production

    private static var _env: Environment!
    public private(set) static var current: Environment {
        set { _env = newValue }
        get {
            guard let env = _env else { preconditionFailure("Environment not set! Please set the environment at app launch.") }
            return env
        }
    }

    public static var isDebug: Bool { return current == .development }
    public static var isRelease: Bool { return current == .production }
}

extension Environment {
    @inline(__always) public static func setEnvironment(_ env: Environment, secret: String = "") {
        guard env == .production else { current = env; return }
        current = .production
    }
}
