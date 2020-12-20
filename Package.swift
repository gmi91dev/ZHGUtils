// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZHGUtils",
    // 本 Package 适用的平台
    platforms: [.iOS(.v11)],
    
    products: [.library(
            name: "ZHGUtils",
            targets: ["ZHGUtils"])],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ZHGUtils",
            path: "Sources"),
    ]
)
