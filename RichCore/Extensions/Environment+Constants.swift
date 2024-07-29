// Copyright © 2020 PeoGooCore. All rights reserved.
import Foundation

/// All constants that can be set upon request.
public extension Environment {
    /// Whether analytics should be tracked.
    static var analyticsEnabled: Bool = true
    /// Whether the analytics logging should be dumped into the console.
    static var debugAnalytics: Bool = false
    /// Whether the server calls directed to our servers should use SSL.
    static var useSSL: Bool = true
    /// Level of noise of the error manager console logging.
    /// - Note: Even when using an option that enables logging errors, the current Environment is taken into consideration and suppresses this option if needed.
    static var errorManagerNoiseLevel: ErrorLoggingNoiseLevel = .allTheThings
    /// The local address to point to when running the backend locally, e.g. "http://192.168.0.2:4000".
    /// No prefix or suffix is added to this string when creating the URL, so you're responsible for adding (or not) "http://", "https://" prefixes and port number.
    /// - Note: This variable is inert in non-debug environments.
    /// - Warning: Setting this variable will force the application to be terminated due to internal requirements.ErrorLoggingNoiseLevel
}

/// All constants that depend on the build environment or are otherwise related to the build environment
public extension Environment {
    /// The app name, e.g. "ETCloud Dev"
    private(set) static var appName: String = ""
    /// The app version, e.g. "2.23.2"
    private(set) static var appVersion: String = ""
    /// The app version, e.g. "qcy343ecloud"
    private(set) static var appScheme: String = ""
    /// The build number, e.g. "2323.23232323"
    private(set) static var buildNumber: String = ""
    /// The app version concatenated with the build number, e.g. "2.23.2.2323.23232323"
    private(set) static var appBuildVersion: String = ""
    /// Target-specific bundle identifier, i.e. equivalent to `Bundle.main.bundleIdentifier!`.
    private(set) static var currentTargetBundleIndentifier: String = ""
    private(set) static var apiHost: String = ""
    private(set) static var oneSignalAppID: String = ""
    private(set) static var h5Host: String = ""
    private(set) static var appStoreId: String = ""
    private(set) static var appStoreUrl: String = ""
    /// 微信相关
    private(set) static var wechatAppId: String = ""
    private(set) static var wechatAppSecret: String = ""
    private(set) static var wechatUniversalUrl: String = ""
    /// 支付宝相关
    private(set) static var aliAppId: String = ""
    /// 极光一键登录
    private(set) static var jiguangSignInAppkey = ""
    /// 友盟APPID
    private(set) static var umengAppId = ""
    /// 更新版本 维护公告
    private(set) static var updateVersionUrl = ""
    /// 员工业绩排名
    private(set) static var rankUrl = ""
    /// app 渠道
    private(set) static var appSource = ""
    /// 腾讯云
    private(set) static var tencentAppId: Int = 0
    /// 信息管委会 ID
    // TODO: 临时方案 需要接口控制用户身份
    private(set) static var infoManagerId: Int = 0
    
    /// Configures all environment constants.
    /// Note: Can only be called once during the app lifetime
    ///
    /// - Parameter env: the wanted environment
    internal static func configure(with env: Environment, with secret: String = "") {
        // Set the environment
        setEnvironment(env, secret: secret)
        // Set common constants
        appName = (Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String)!
        appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
        appScheme = "qcy343ecloud"
        buildNumber = (Bundle.main.infoDictionary?["CFBundleVersion"] as? String)!
        currentTargetBundleIndentifier = Bundle.main.bundleIdentifier!
        appStoreId = "1514713710"
        appStoreUrl = String(format: "https://itunes.apple.com/cn/app/id%@?mt=8", appStoreId)
        
        wechatAppId = "wxd7626ece549eb10e"
        wechatAppSecret = "bdfc324a83b44d884089ea6beda5b062"
        wechatUniversalUrl = "https://www.topbic.com/ios/"
        
        appSource = "App store"
        tencentAppId = 1302179292
        // Set env dependent constants
        switch current {
        case .development:
            apiHost = "http://10.20.26.32:15199"
            updateVersionUrl = "https://test-k8s-qiceyun-json.peogoo.com/qicecloud/upgradeMaintenance.json"
            // Key and Id
            jiguangSignInAppkey = "aa69922850fab4dafa21def3"
            umengAppId = "60f53376bffa185e76f9f8ba"
            appBuildVersion = String(format: "%@.%@", appVersion, buildNumber)
            aliAppId = "ali2021002128607260"
            infoManagerId = 30494275
            rankUrl = "https://test-qiceyun-flutter-pc.peogoo.com/"
        case .production:
            apiHost = "https://gateway.topbic.com"
            h5Host = "https://gateway.topbic.com"
            updateVersionUrl = "https://json.topbic.com/json/upgradeMaintenance.json"
            // Key and Id
            jiguangSignInAppkey = "de1029040de447d4bf0d98b9"
            umengAppId = "60f9075e173f3b21b451ebc1"
            appBuildVersion = appVersion
            aliAppId = "ali2021002127627236"
            infoManagerId = 30494275
            rankUrl = "https://gatecloud.topbic.com/web/"
        }
    }

    /// Holds info for debugging a user
    struct User {
        public let deviceID: String
        public let userID: String
        public let token: String

        public init(deviceID: String, userID: String, token: String) {
            (self.deviceID, self.userID, self.token) = (deviceID, userID, token)
        }
    }
}

extension Environment {
    static func computeEnvironment() -> Environment {
        #if DEV
            return .development
        #else
            return .production
        #endif
    }
}

// MARK: Legacy
@objc public class ObjC_Environment : NSObject {
    @objc public static var APP_BUILD_VERSION: String { return Environment.appBuildVersion }
    @objc public static var APP_VERSION: String { return Environment.appVersion }
    @objc public static var APP_SCHEME: String { return Environment.appScheme }
    @objc public static var BUNDLE_IDENTIFIER: String { return Environment.currentTargetBundleIndentifier }
    @objc public static var API_HOST: String { return Environment.apiHost }
    @objc public static var H5_HOST: String { return Environment.h5Host }
    @objc public static var UPDATE_VERSION_URL: String { return Environment.updateVersionUrl }
    @objc public static var UM_APP_ID: String { return Environment.umengAppId }
    @objc public static var JG_APP_KEY: String { return Environment.jiguangSignInAppkey }
    @objc public static var WX_APP_ID: String { return Environment.wechatAppId }
    @objc public static var WX_APP_SECRET: String { return Environment.wechatAppSecret }
    @objc public static var WX_UNIVERSAL_LINK: String { return Environment.wechatUniversalUrl }
    @objc public static var APP_SOURCE: String { return Environment.appSource }
    @objc public static var APP_STORE_ID: String { return Environment.appStoreId }
    @objc public static var APP_STORE_URL: String { return Environment.appStoreUrl }
    
    @objc static func configureEnvironment() {
        Environment.configure(with: Environment.computeEnvironment())
    }
}
