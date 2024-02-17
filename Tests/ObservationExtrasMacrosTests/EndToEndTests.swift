import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(ObservationExtrasMacros)
import ObservationExtrasMacros

private let testMacros: [String: Macro.Type] = [
    "observeState": ObserveStateMacro.self,
    "Observing": ObservingMacro.self
]
#endif

final class EndToEndTests: XCTestCase {
    func test_integration_expansion() {
        assertMacroExpansion(
            """
            @Observing
            class Class {
                @observeState
                func observingFunc() {}
                
                func notObservingFunc() {}
            }
            """,
            expandedSource:
            """
            class Class {
                func observingFunc() {}

                private func _$observingFunc() {
                    withObservationTracking {
                        observingFunc()
                    } onChange: {
                        Task { [weak self] in
                            await self?._$observingFunc()
                        }
                    }
                }
                
                func notObservingFunc() {}

                private func observeState() {
                    _$observingFunc()
                }
            }
            """,
            macros: testMacros
        )
    }
}
