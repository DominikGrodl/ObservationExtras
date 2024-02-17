// swift-tools-version: 5.9

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "ObservationExtras",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "ObservationExtras",
            targets: [
                "ObservationExtras"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax", from: "509.0.0")
    ],
    targets: [
        .target(
            name: "ObservationExtras",
            dependencies: [
                "ObservationExtrasMacros"
            ]
        ),
        .macro(
            name: "ObservationExtrasMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        .testTarget(
            name: "ObservationExtrasMacrosTests",
            dependencies: [
                "ObservationExtrasMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
            ]
        )
    ]
)
