// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Foundry",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Foundry",
            targets: ["Foundry"]
        ),
    ],
    targets: [
        .target(
            name: "Foundry",
            dependencies: [],
            path: "Sources/Foundry"
        ),
        .testTarget(
            name: "FoundryTests",
            dependencies: ["Foundry"],
            path: "Tests/FoundryTests"
        ),
    ]
)
