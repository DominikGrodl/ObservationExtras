import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct ObservingMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let classDecl = declaration.as(ClassDeclSyntax.self) else {
            throw DiagnosticsError.observingMustBeClass
        }
        
        let methods = classDecl.memberBlock.members
            .compactMap { member in
                member.decl.as(FunctionDeclSyntax.self)
            }
        
        let observingMethods = methods
            .filter { decl in
                decl.attributes.contains { attribute in
                    attribute
                        .as(AttributeSyntax.self)?
                        .attributeName
                        .as(IdentifierTypeSyntax.self)?
                        .name.text == "observeState"
                }
            }
        
        let qualifiedMethodsIdentifiers = observingMethods
            .compactMap { $0.as(FunctionDeclSyntax.self) }
            .map { decl in
                "_$\(decl.name.description)()"
            }
            .joined(separator: "\n")
        
        let observeStateFunction =
        """
        private func observeState() {
            \(qualifiedMethodsIdentifiers)
        }
        """
        
        return [.init(stringLiteral: observeStateFunction)]
    }
}
