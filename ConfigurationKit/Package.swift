// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "ConfigurationKit",
    platforms: [.iOS("14.0"), .macOS("11")],
    products: [
        .library(
            name: "ConfigurationKit",
            targets: ["ConfigurationKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ConfigurationKit",
            dependencies: []),
        .testTarget(
            name: "ConfigurationKitTests",
            dependencies: ["ConfigurationKit"]),
    ]
)
