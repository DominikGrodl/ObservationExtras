import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(ObservationExtrasMacros)
import ObservationExtrasMacros

private let testMacros: [String: Macro.Type] = [
    "observeState": ObserveStateMacro.self
]
#endif

final class ObservationExtrasTests: XCTestCase {
    func test_expansion() {
        assertMacroExpansion(
            """
            @observeState
            func observingFunc() {}
            """,
            expandedSource:
            """
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
            """,
            macros: testMacros
        )
    }
    
    func test_expansion_on_struct_emits_error() {
        assertMacroExpansion(
            """
            @observeState
            struct Struct {}
            """,
            expandedSource: 
            """
            struct Struct {}
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "@observingState may be applied only to functions",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }
    
    func test_expansion_on_class_emits_error() {
        assertMacroExpansion(
            """
            @observeState
            class Class {}
            """,
            expandedSource:
            """
            class Class {}
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "@observingState may be applied only to functions",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }
    
    func test_expanision_on_actor_emits_error() {
        assertMacroExpansion(
            """
            @observeState
            actor Actor {}
            """,
            expandedSource:
            """
            actor Actor {}
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "@observingState may be applied only to functions",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }
    
    func test_expansion_on_enum_emits_error() {
        assertMacroExpansion(
            """
            @observeState
            enum Enum {}
            """,
            expandedSource:
            """
            enum Enum {}
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "@observingState may be applied only to functions",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }
    
    func test_expansion_on_stored_property_emits_error() {
        assertMacroExpansion(
            """
            @observeState
            var abc: String
            """,
            expandedSource:
            """
            var abc: String
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "@observingState may be applied only to functions",
                    line: 1,
                    column: 1
                )
            ],
            macros: testMacros
        )
    }
}
