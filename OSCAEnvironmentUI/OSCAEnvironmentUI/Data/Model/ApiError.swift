public enum ApiError: Error {
    case Timeout
    case NoResult
    case ConnectionError
    case CastError
    case Unknown(error: Error)
}
