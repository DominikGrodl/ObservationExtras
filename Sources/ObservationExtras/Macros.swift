// The Swift Programming Language
// https://docs.swift.org/swift-bookd

/// Marks that the method interacts with Observable state and should re-run anytime the state changes.
///
/// ```
/// @observeState()
/// ```
///
@attached(peer, names: arbitrary)
public macro observeState() = #externalMacro(
    module: "ObservationExtrasMacros",
    type: "ObserveStateMacro"
)

/// Provides the class with ability to observe changes in underlying Observable class.
///
/// ```
/// @Observable(providesInheritance: Bool = false)
/// ```
///
/// Specify providesInheritance = true if you class inherits from ObservingUIViewController.
/// If you class inherits from ObservingUIViewController, no additional orchestration (other than marking methods with @observeState) is needed. If not, call observeState() on the entypoint to this class, or in ViewDidLoad.
///
/// - Parameters:
///     - providesInheritance: whether or not the marked class provides observing superclass.
///         - default: false
@attached(member, names: named(observeState))
public macro Observing(providesInheritance: Bool = false) = #externalMacro(
    module: "ObservationExtrasMacros",
    type: "ObservingMacro"
)
