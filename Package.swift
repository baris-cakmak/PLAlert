// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PLAlert",
    products: [
        .library(
            name: "PLAlert",
            targets: ["PLAlert"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PLAlert",
            dependencies: [])
    ]
)
