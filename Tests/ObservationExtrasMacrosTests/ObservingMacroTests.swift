import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(ObservationExtrasMacros)
import ObservationExtrasMacros

private let testMacros: [String: Macro.Type] = [
    "Observing": ObservingMacro.self
]
#endif

final class ObservingMacroTests: XCTestCase {
    func test_expansion_without_inheritance() {
        assertMacroExpansion(
        """
        @Observing(providesInheritance: false)
        class Class {}
        """,
        expandedSource:
        """
        class Class {

            private func observeState() {

            }}
        """,
        macros: testMacros
        )
    }
    
    func test_expansion_with_inheritance() {
        assertMacroExpansion(
        """
        @Observing(providesInheritance: true)
        class Class {}
        """,
        expandedSource:
        """
        class Class {

            override func observeState() {

            }}
        """,
        macros: testMacros
        )
    }
    
    func test_expansion_without_argument() {
        assertMacroExpansion(
        """
        @Observing
        class Class {}
        """,
        expandedSource:
        """
        class Class {

            private func observeState() {

            }}
        """,
        macros: testMacros
        )
    }
    
    func test_expansion_on_struct_emits_error() {
        assertMacroExpansion(
        """
        @Observing
        struct Struct {}
        """,
        expandedSource:
        """
        struct Struct {}
        """,
        diagnostics: [
            DiagnosticSpec(message: "@Observing may be applied only to classes", line: 1, column: 1)
        ],
        macros: testMacros
        )
    }
    
    func test_expansion_on_enum_emits_error() {
        assertMacroExpansion(
        """
        @Observing
        enum Enum {}
        """,
        expandedSource:
        """
        enum Enum {}
        """,
        diagnostics: [
            DiagnosticSpec(message: "@Observing may be applied only to classes", line: 1, column: 1)
        ],
        macros: testMacros
        )
    }
    
    func test_expansion_on_actor_emits_error() {
        assertMacroExpansion(
        """
        @Observing
        actor Actor {}
        """,
        expandedSource:
        """
        actor Actor {}
        """,
        diagnostics: [
            DiagnosticSpec(message: "@Observing may be applied only to classes", line: 1, column: 1)
        ],
        macros: testMacros
        )
    }
}
