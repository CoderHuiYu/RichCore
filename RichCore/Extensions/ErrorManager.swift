// Copyright © 2020 PeoGooCore. All rights reserved.

/// Singleton instance of the ErrorManager.
private var _errorManager: ErrorManager?
public var errorManager: ErrorManager { return _errorManager! }

public func setErrorManager(_ errorManager: ErrorManager) {
    assert(_errorManager == nil)
    _errorManager = errorManager
}

/// An abstract error manager, designed to be a project-agnostic manager to handle errors in any environment supported by Tellus.
// TODO: Consider making this protocol open/public.
public protocol ErrorManager {
    /// A closure executed when the user performs an action on an error's alert message, e.g. by pressing "Ok".
    /// Specially useful when the user's action on the button could trigger a navigation flow.
    var actionClosure: ActionClosure? { get }
    /// Handle an error, taking an appropriate action, like displaying an alert with the best appropriate message to the user.
    ///
    /// - Parameters:
    ///   - error: error to be handled.
    ///   - fallbackMessage: fallback message to be shown to the user in case there's no better message to be shown.
    ///   - silently: if the error handling is done silently, no user-facing alert is shown. It will still track error events to analytics?.
    /// - Returns: a void Operation that succeeds if the error sent was `nil`, otherwise errors out with the unwrapped `error` object.
    /// - Note: This method handles errors synchronously and the operation is only returned after the errors have been handled.
    @discardableResult func handleError(_ error: Error?, fallbackMessage: String?, silently: Bool) -> Operation<Void>
    /// Handle connectivity errors, i.e. all errors that are in the NSURLErrorDomain domain. E.g.: timeout, no internet, unreachable server, etc.
    /// - Returns: Whether the method could handle the error or not.
    func handleConnectionError(_ error: Error, fallbackMessage: String?) -> Bool
    /// Handle errors coming from our servers that could be properly parsed into our predefined server error structure.
    /// - Returns: Whether the method could handle the error or not.
    func handleServerError(_ error: Error, fallbackMessage: String?) -> Bool
    /// Handle locally generated errors, e.g. input validation, parsing errors, etc.
    /// - Returns: Whether the method could handle the error or not.
    func handleLocallyGeneratedError(_ error: Error, fallbackMessage: String?) -> Bool
    /// Handle other errors that don't fit the other categories, e.g. 3rd party library errors, I/O errors, etc.
    /// - Returns: Whether the method could handle the error or not.
    func handleOtherError(_ error: Error, fallbackMessage: String?) -> Bool
    /// Log error to analytics?. Must be implemented by subclasses.
    func trackAnalytics(for error: Error, with attributes: [String:Any])

    @discardableResult func handleAccessDeniedToChannelIfNeeded(channelID: String, error: Error) -> Bool
}

extension ErrorManager {
    @discardableResult public func handleErrorSilently(_ error: Error?) -> Operation<Void> {
        return handleError(error, fallbackMessage: nil, silently: true)
    }
}

/// Level of noise of the error logs on the console.
///
/// - shush: No error will be displayed on the logs.
/// - justServerErrors: Only the Tellus-generated server errors will be displayed on the logs.
/// - allTheThings: Any kind of error will be displayed on the logs.
public enum ErrorLoggingNoiseLevel {
    case shush, justServerErrors, allTheThings
}
