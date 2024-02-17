enum DiagnosticsError: Error, CustomStringConvertible {
    case observingMustBeClass
    case observerMustBeFunction
    
    var description: String {
        switch self {
        case .observingMustBeClass:
            return "@Observing may be applied only to classes"
            
        case .observerMustBeFunction:
            return "@observingState may be applied only to functions"
        }
    }
}
