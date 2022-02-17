// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "XCATMDBClient",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "XCATMDBClient",
            targets: ["XCATMDBClient"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "XCATMDBClient",
            dependencies: [])
    ]
)
