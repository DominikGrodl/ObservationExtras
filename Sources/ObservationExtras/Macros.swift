// The Swift Programming Language
// https://docs.swift.org/swift-bookd

@attached(peer, names: arbitrary)
public macro observeState() = #externalMacro(
    module: "ObservationExtrasMacros",
    type: "ObserveStateMacro"
)

@attached(member, names: named(observeState))
public macro Observing(providesInheritance: Bool = false) = #externalMacro(
    module: "ObservationExtrasMacros",
    type: "ObservingMacro"
)
