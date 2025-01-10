// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LabsPlatformSwift",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LabsPlatformSwift",
            targets: ["LabsPlatformSwift"]),
    ],
    dependencies: [
            .package(url: "https://github.com/openid/AppAuth-iOS.git", from: "1.7.6"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LabsPlatformSwift",
            dependencies: [
                .product(name: "AppAuth", package: "appauth-ios"),
            ]
        ),
        .testTarget(
            name: "LabsPlatformSwiftTests",
            dependencies: ["LabsPlatformSwift"]
        ),
    ]
)
