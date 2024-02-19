import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct ObserveStateMacro: PeerMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        guard let funcDecl = declaration.as(FunctionDeclSyntax.self) else {
            throw DiagnosticsError.observerMustBeFunction
        }
        
        let ogFunctionName = "\(funcDecl.name.description)"
        let functionName = "_$\(ogFunctionName)"
        
        let result =
        """
        private func \(functionName)() {
            withObservationTracking { [weak self] in
                self?.\(ogFunctionName)()
            } onChange: { [weak self] in
                Task { @MainActor [weak self] in
                    self?.\(functionName)()
                }
            }
        }
        """
        
        return [
            .init(stringLiteral: result)
        ]
    }
}
